# swift-mailgun-http

[![CI](https://github.com/swift-foundations/swift-mailgun-http/actions/workflows/ci.yml/badge.svg)](https://github.com/swift-foundations/swift-mailgun-http/actions/workflows/ci.yml)
![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

HTTP wire construction, authentication, and JSON decoding for the typed Mailgun operations published by `swift-mailgun`.

## Overview

`swift-mailgun-http` maps every Mailgun REST resource — Messages, Domains, Suppressions, Reporting, Templates, Webhooks, Mailing Lists, Routes, IPs/IP Pools/Warmup, and account management (Subaccounts, Users, Credentials, Keys, Custom Message Limit) — to Foundation-free `HTTP.Request` values, and decodes Mailgun's JSON responses back into `swift-mailgun-standard`'s typed vocabulary. It provides:

- pure, unauthenticated wire-request constructors for every resource, one Swift Testing case per corpus fixture verifying exact method/path/query/headers/body;
- HTTP Basic authentication built once at client construction (not re-encoded per request);
- an injected-transport execution client, so any HTTP backend (URLSession, a test double, a server-side client) can drive it;
- an ergonomic wrapper vending `swift-mailgun`'s closure-bag `Client<Failure>` structs, wired end-to-end (construct → send → decode).

## Installation

Add the package dependency:

```swift
dependencies: [
    .package(
        url: "https://github.com/swift-foundations/swift-mailgun-http.git",
        branch: "main"
    )
]
```

Then add the product to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Mailgun HTTP", package: "swift-mailgun-http")
    ]
)
```

## Usage

```swift
import Mailgun_HTTP

let client = Mailgun.HTTP.Client(
    authentication: .init(apiKey: apiKey),
    execute: transport.execute
)

// The ergonomic surface: swift-mailgun's Client<Failure>, wired end-to-end.
let domain = try Domain("mg.example.com")
let mailgun = client.mailgun(domain: domain)

let sent = try await mailgun.messages.send(
    .init(
        from: try EmailAddress("noreply@mg.example.com"),
        to: [try EmailAddress("user@example.com")],
        subject: "Hello",
        text: "Hello from Mailgun!"
    )
)

let domains = try await mailgun.domains.list()
let bounces = try await mailgun.suppressions.bounces.list()
```

Every resource is also reachable individually, without the full `Mailgun.Client` composite:

```swift
let routes = client.routes()
let created = try await routes.create(
    .init(priority: 0, description: "forward", expression: #"match_recipient(".*@example.com")"#, action: ["stop()"])
)

let webhooks = client.webhooks(domain: domain)
let hooks = try await webhooks.list()
```

Or drop to the pure wire-construction layer directly — no authentication, no execution, just the `HTTP.Request` value the corpus tests verify:

```swift
let request = try Mailgun.HTTP.Routes.list(limit: 25, skip: 0)
// request.method, request.path, request.query, request.headers, request.body
```

## Architecture

Three layers, each owning a different concern:

- **`Mailgun Standard`** (L2, `swift-mailgun-standard`) owns the wire-shaped vocabulary — every `Request`/`Response` DTO, `Codable` and wire-accurate.
- **`Mailgun`** (`swift-mailgun`) owns the typed, closure-bag `Client<Failure>` per resource — the shape every wrapper in this package targets.
- **`Mailgun HTTP`** (this package) owns everything between the two: request construction, authentication, transport execution, and response decoding.

Within this package, two sub-layers keep wire-fact correctness independent of the outer wrapper:

- **`Mailgun.HTTP.<Resource>.<operation>(...)`** — pure, static, unauthenticated, origin-form `HTTP.Request` builders. This is the entire corpus-tested surface (`Tests/Mailgun HTTP Tests/__Corpus__`): one Swift Testing case per fixture, asserting exact method/path/query/headers/body.
- **`Mailgun.HTTP.Client.<resource>(...)`** — wires a builder above into `send(_:)` (attaches host + cached `Authorization` header, executes via the injected transport) and decodes the JSON response, producing one of `swift-mailgun`'s `Client<Failure>` structs. Not corpus-driven — the fixtures carry no host or auth — but exercised by construction (every closure in every `Client<Failure>` is wired to something).

Resources that are domain-scoped at the wire level but not in `swift-mailgun`'s `Client<Failure>` shape (`Messages`, `Webhooks`, `Templates`, `Reporting.Events`, `Reporting.Tags`, and all four `Suppressions` sub-resources) take `domain` once, at the wrapper factory call, rather than per operation.

Per-resource array and boolean rendering isn't uniform across the API — most resources repeat a bare key (`action=a&action=b`) and render booleans as `yes`/`no`; `Webhooks` and `IPPools` need `key[]=` bracket arrays; `Domains`, `Domains.Tracking`, `Domains.DKIMSecurity`, `Credentials`, `IPs.Warmup`, and `Subaccounts.updateFeatures` render booleans as literal `true`/`false` instead. The corpus fixture is authoritative per operation, not a fixed convention across the whole API — `Lists.bulkAdd` and `.addMember` even disagree with each other on this within the same resource.

## Gaps

Four operations are not implemented. Each is a real gap, not an oversight — calling the corresponding closure on the wrapped `Client<Failure>` always throws `Mailgun.HTTP.Error.unsupported` rather than silently doing the wrong thing:

- **`Lists.bulkAddCSV`** — the archived router encoded the CSV payload as a raw `Data`-typed *path* component (not a body), which both fails RFC 3986 path-segment legality for any payload containing the row-separating newline the operation exists to carry, and isn't fully captured by its own corpus fixture (the fixture's line-oriented format truncates at the first embedded newline).
- **`Suppressions.Bounces.importList`**, **`Suppressions.Unsubscribe.importList`**, **`Suppressions.Allowlist.importList`** — these draw a random multipart boundary through a `.csv` file-upload encoder preset that belonged to the deleted `-Live` architecture and no longer exists in the current `swift-html-form-coder`. (`Suppressions.Complaints.importList`, by contrast, uses a fixed boundary and a plain base64 text field — fully implemented and corpus-verified.)

See [swift-mailgun-http#7](https://github.com/swift-foundations/swift-mailgun-http/issues/7) for the record.

## Testing

Every wire constructor is verified against `Tests/Mailgun HTTP Tests/__Corpus__` — parity fixtures carrying the exact method, path, query, headers, and body a working implementation must produce, one Swift Testing case per fixture. Two fixture families need special comparison handling, both provided by `Corpus.Case`:

- `expect(matches:)` — exact comparison, the default.
- `expect(matchesNormalizingBoundary:)` — for `Messages.send`/`.sendMime`, whose multipart boundary is drawn fresh (`Part-<UUID>`) on every call; normalizes the actual boundary to the fixture's `Part-<NORMALIZED>` placeholder before comparing.

Tests inject no live transport and make no network calls.

## Error Handling

Wire construction throws `Mailgun.HTTP.Construction.Error`:

```
Mailgun.HTTP.Construction.Error
├── .path(RFC_3986.URI.Path.Error)         // a path segment was not RFC 3986 legal
├── .query(RFC_3986.URI.Query.Error)       // a query parameter was not RFC 3986 legal
├── .boundary(RFC_2046.Boundary.Error)     // a multipart boundary was not RFC 2046 legal
├── .header(HTTP.Header.Field.Error)       // a header field's value was not RFC 9110 legal
├── .coding(HTML.Form.Coder.Error)         // form or multipart body encoding failed
├── .json(String)                          // JSON body encoding failed (Reporting.Logs/Metrics)
└── .messagesMultipart(String)             // hand-rolled multipart assembly failed (Messages)
```

The client wrapper widens this into `Mailgun.HTTP.Error<ExecutionFailure>`:

```
Mailgun.HTTP.Error<ExecutionFailure>
├── .construction(Mailgun.HTTP.Construction.Error)  // building the request failed
├── .execute(ExecutionFailure)                      // the injected transport failed
├── .decode(String)                                 // the response body wasn't the expected JSON shape
└── .unsupported(String)                             // no wire constructor exists yet — see Gaps
```

## License

This package is licensed under the AGPL 3.0 License. See [LICENSE.md](LICENSE.md) for details.
