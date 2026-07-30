import Domain_Standard
import EmailAddress_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Suppressions.Unsubscribe`
/// (docs section "Unsubscribes").
///
/// Ported from the archived `Mailgun Suppressions Types/Unsubscribe/Unsubscribe.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Suppressions.Unsubscribe.txt` — all
/// but `importList`. `create`'s `tags` array renders bracketed
/// (`.mailgunBracketed`, `tags[]=...`), unlike most other resources'
/// repeated bare key.
///
/// `importList` is not ported — same reason as `Bounces.importList`: the
/// archived router's `.csv` multipart file-upload encoder preset belonged to
/// the deleted `-Live` architecture and no longer exists, the operation
/// draws a random boundary (matching the corpus's
/// `boundary=----FormBoundary<NORMALIZED>` placeholder), and the corpus's
/// own `KNOWN-NON-ROUNDTRIP.txt` already flags
/// `Suppressions.Unsubscribe.importList` as "multipart body not
/// value-recoverable".
extension Mailgun.HTTP.Suppressions {
    public enum Unsubscribe: Sendable {}
}

extension Mailgun.HTTP.Suppressions.Unsubscribe {
    public static func get(
        _ domain: Domain,
        address: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "unsubscribes", address.rawValue]
        )
    }

    public static func delete(
        _ domain: Domain,
        address: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", domain.rawValue, "unsubscribes", address.rawValue]
        )
    }

    public static func list(
        _ domain: Domain,
        _ request: Mailgun.Suppressions.Unsubscribe.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let address = request?.address { query.append(("address", address.rawValue)) }
        if let term = request?.term { query.append(("term", term)) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        if let page = request?.page { query.append(("page", page)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "unsubscribes"],
            query: query
        )
    }

    public static func create(
        _ domain: Domain,
        _ request: Mailgun.Suppressions.Unsubscribe.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", domain.rawValue, "unsubscribes"]
        )
        try Mailgun.HTTP.Construction.form(request, encoder: .mailgunBracketed, into: &httpRequest)
        return httpRequest
    }

    public static func deleteAll(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v3", domain.rawValue, "unsubscribes"])
    }
}
