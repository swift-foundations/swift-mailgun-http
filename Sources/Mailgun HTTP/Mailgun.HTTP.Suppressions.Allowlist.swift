import Domain_Standard
import EmailAddress_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Suppressions.Allowlist`
/// (docs section "Allowlists" — the wire path is still `whitelists`, the
/// API's pre-rename term, matching the archived router exactly).
///
/// Ported from the archived `Mailgun Suppressions Types/Allowlist/Allowlist API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Suppressions.Allowlist.txt` — all
/// but `importList`. `get`/`delete` address a bare `String` value (an email
/// address or a domain name — Mailgun allowlists either), not a typed
/// `EmailAddress`. `create`'s request is a two-case enum
/// (`.address`/`.domain`) whose hand-written `Codable` conformance encodes
/// exactly one of the two keys — `Mailgun.HTTP.Construction.form` handles it
/// the same as any other `Encodable` value.
///
/// `importList` is not ported — same reason as `Bounces.importList`: the
/// archived router's `.csv` multipart file-upload encoder preset belonged to
/// the deleted `-Live` architecture and no longer exists, the operation
/// draws a random boundary (matching the corpus's
/// `boundary=----FormBoundary<NORMALIZED>` placeholder), and the corpus's
/// own `KNOWN-NON-ROUNDTRIP.txt` already flags
/// `Suppressions.Allowlist.importList` as "multipart body not
/// value-recoverable".
extension Mailgun.HTTP.Suppressions {
    public enum Allowlist: Sendable {}
}

extension Mailgun.HTTP.Suppressions.Allowlist {
    public static func get(
        _ domain: Domain,
        value: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "whitelists", value]
        )
    }

    public static func delete(
        _ domain: Domain,
        value: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", domain.rawValue, "whitelists", value]
        )
    }

    public static func list(
        _ domain: Domain,
        _ request: Mailgun.Suppressions.Allowlist.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let address = request?.address { query.append(("address", address.rawValue)) }
        if let term = request?.term { query.append(("term", term)) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        if let page = request?.page { query.append(("page", page)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "whitelists"],
            query: query
        )
    }

    public static func create(
        _ domain: Domain,
        _ request: Mailgun.Suppressions.Allowlist.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", domain.rawValue, "whitelists"]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func deleteAll(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v3", domain.rawValue, "whitelists"])
    }
}
