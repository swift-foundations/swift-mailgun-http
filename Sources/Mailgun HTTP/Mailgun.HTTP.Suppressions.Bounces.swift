import Domain_Standard
import EmailAddress_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Suppressions.Bounces` (docs
/// section "Bounces").
///
/// Ported from the archived `Mailgun Suppressions Types/Bounces/Bounces.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Suppressions.Bounces.txt` — all but
/// `importList`.
///
/// `importList` is not ported: the archived router encodes it as a
/// `multipart/form-data` file upload (`encoder: .csv`, no explicit boundary)
/// under a randomly generated boundary, matching the corpus's
/// `boundary=----FormBoundary<NORMALIZED>` placeholder. Two things block a
/// verified port: the `.csv` multipart encoder preset referenced by the
/// archived router belonged to the deleted `-Live` architecture and no
/// longer exists in the current `swift-html-form-coder`, so reproducing its
/// file-attachment shape (`Content-Disposition: form-data;
/// filename="import.csv"; name="file"`, `Content-Type: text/csv`) would mean
/// inventing unverified encoder configuration; and even with that shape
/// rebuilt, the corpus fixture's own `KNOWN-NON-ROUNDTRIP.txt` already flags
/// `Bounces.importList` as "multipart body not value-recoverable" — the
/// random boundary makes this operation's bytes non-deterministic by
/// design, a case the corpus format itself only partially captures.
extension Mailgun.HTTP.Suppressions {
    public enum Bounces: Sendable {}
}

extension Mailgun.HTTP.Suppressions.Bounces {
    public static func get(
        _ domain: Domain,
        address: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "bounces", address.rawValue]
        )
    }

    public static func delete(
        _ domain: Domain,
        address: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", domain.rawValue, "bounces", address.rawValue]
        )
    }

    public static func list(
        _ domain: Domain,
        _ request: Mailgun.Suppressions.Bounces.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        if let page = request?.page { query.append(("page", page)) }
        if let term = request?.term { query.append(("term", term)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "bounces"],
            query: query
        )
    }

    public static func create(
        _ domain: Domain,
        _ request: Mailgun.Suppressions.Bounces.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", domain.rawValue, "bounces"]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func deleteAll(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v3", domain.rawValue, "bounces"])
    }
}
