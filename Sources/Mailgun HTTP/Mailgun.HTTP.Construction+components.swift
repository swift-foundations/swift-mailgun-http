import Byte_Primitive
import Domain_Standard
import Foundation
import HTML_Form_Coder_Codable
import HTML_Standard
import HTTP_Body
import HTTP_Standard
import RFC_2046
import RFC_3986

/// Shared building blocks every `Mailgun.HTTP.<Resource>` request constructor
/// composes from: origin-form path/query, and form / multipart body encoding.
///
/// Every constructor returns an origin-form, unauthenticated `HTTP.Request` —
/// no scheme, host, or `Authorization` header. `Mailgun.HTTP.Client.authenticated(_:)`
/// adds those. This split is what makes the constructors directly comparable
/// against `Tests/Mailgun HTTP Tests/__Corpus__`, whose fixtures record only
/// method, path, query, headers, and body.
extension Mailgun.HTTP.Construction {
    /// Builds an RFC 3986 absolute path from literal segments.
    static func path(_ segments: [String]) throws(Error) -> RFC_3986.URI.Path {
        do throws(RFC_3986.URI.Path.Error) {
            return try RFC_3986.URI.Path(segments: segments)
        } catch {
            throw .path(error)
        }
    }

    /// Builds an RFC 3986 query from present parameters, or `nil` when none
    /// are present — Mailgun's corpus omits the query line entirely rather
    /// than emitting an empty `?`.
    static func query(_ parameters: [(String, String)]) throws(Error) -> RFC_3986.URI.Query? {
        guard !parameters.isEmpty else { return nil }
        do throws(RFC_3986.URI.Query.Error) {
            return try RFC_3986.URI.Query(parameters.map { ($0.0, $0.1 as String?) })
        } catch {
            throw .query(error)
        }
    }

    /// Validates a literal boundary string (either a fixed per-operation
    /// constant, or one freshly drawn from `RFC_2046.Boundary.random()`).
    static func boundary(_ rawValue: String) throws(Error) -> RFC_2046.Boundary {
        do throws(RFC_2046.Boundary.Error) {
            return try RFC_2046.Boundary(rawValue)
        } catch {
            throw .boundary(error)
        }
    }

    /// Builds a header field for an operation that carries state outside its
    /// path/query/body — e.g. `Mailgun.Subaccounts.delete`'s
    /// `X-Mailgun-On-Behalf-Of`.
    static func header(_ name: String, _ value: String) throws(Error) -> HTTP.Header.Field {
        do throws(HTTP.Header.Field.Error) {
            return try HTTP.Header.Field(name: name, value: value)
        } catch {
            throw .header(error)
        }
    }

    /// Validates a raw `String` as a `Domain` — only the
    /// `Mailgun.HTTP.Client` wrapper for `Mailgun.HTTP.IPs.deleteDomainIP`/
    /// `.deleteDomainPool` needs this (see `Construction.Error.domain`).
    static func domain(_ rawValue: String) throws(Error) -> Domain {
        do throws(Domain.Error) {
            return try Domain(rawValue)
        } catch {
            throw .domain(error)
        }
    }

    /// An origin-form request with no body: method, path, and optional query.
    static func request(
        _ method: HTTP.Method,
        _ segments: [String],
        query parameters: [(String, String)] = []
    ) throws(Error) -> HTTP.Request {
        HTTP.Request(
            method: method,
            path: try path(segments),
            query: try query(parameters)
        )
    }

    /// Encodes `value` as `application/x-www-form-urlencoded` and installs it
    /// (with its `Content-Type`) as `request`'s body.
    static func form<Value: Swift.Codable>(
        _ value: Value,
        decoder: HTML.Form.Coder.Decoder = .init(),
        encoder: HTML.Form.Coder.Encoder = .mailgun,
        into request: inout HTTP.Request
    ) throws(Error) {
        do {
            try request.body(
                set: value,
                using: HTML.Form.Coder.Value(Value.self, decoder: decoder, encoder: encoder)
            )
        } catch {
            throw .coding(error)
        }
    }

    /// Encodes `value` as `multipart/form-data` under `boundary` and installs
    /// it (with its `Content-Type`, including the boundary parameter) as
    /// `request`'s body.
    static func multipart<Value: Swift.Codable>(
        _ value: Value,
        boundary: RFC_2046.Boundary,
        into request: inout HTTP.Request
    ) throws(Error) {
        do {
            try request.body(
                set: value,
                using: HTML.Form.Coder.Multipart.Value(Value.self, boundary: boundary)
            )
        } catch {
            throw .coding(error)
        }
    }

    /// Encodes `value` as `application/json` (keys sorted alphabetically) and
    /// installs it as `request`'s body.
    ///
    /// `Mailgun.Reporting.Logs.analytics` and `Mailgun.Reporting.Metrics.*`
    /// are the only operations in this package whose wire body is JSON
    /// rather than `application/x-www-form-urlencoded` or
    /// `multipart/form-data` — every corpus fixture for them was captured
    /// with sorted keys (`body(utf8/sorted-keys):`).
    ///
    /// Uses `Foundation.JSONEncoder` rather than the ecosystem's RFC 8259
    /// codec (`swift-json`): that package's `JSON` target depends on
    /// `swift-async`, which (as of this writing) pulls in `swift-kernel`
    /// completion-port bindings that fail to compile on this toolchain — a
    /// pre-existing, unrelated defect out of scope for this repository to
    /// fix. `JSONEncoder.outputFormatting = [.sortedKeys]` reproduces the
    /// corpus's sorted-keys byte output exactly for these three operations,
    /// which is all this package needs from a JSON encoder.
    static func json<Value: Swift.Encodable>(
        _ value: Value,
        into request: inout HTTP.Request
    ) throws(Error) {
        let encoder = Foundation.JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        let data: Foundation.Data
        do {
            data = try encoder.encode(value)
        } catch {
            throw .json(String(describing: error))
        }
        request.body = data.map(Byte.init)
        request.headers.removeAll(named: "Content-Type")
        request.headers.append(
            try Mailgun.HTTP.Construction.header("Content-Type", "application/json")
        )
    }
}
