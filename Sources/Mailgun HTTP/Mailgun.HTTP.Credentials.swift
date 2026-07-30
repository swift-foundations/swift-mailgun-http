import Domain_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Credentials` (official
/// reference: `.../send/mailgun/domain-credentials`).
///
/// Ported from the archived `Mailgun Credentials Types/Credentials.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Credentials.txt`. `updateMailbox`
/// addresses `/v3/{domain}/mailboxes/{login}` — no `domains` path segment,
/// matching the archived router exactly.
extension Mailgun.HTTP {
    public enum Credentials: Sendable {}
}

extension Mailgun.HTTP.Credentials {
    public static func list(
        domain: Domain,
        _ request: Mailgun.Credentials.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let skip = request?.skip { query.append(("skip", String(skip))) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", "domains", domain.rawValue, "credentials"],
            query: query
        )
    }

    public static func create(
        _ request: Mailgun.Credentials.Create.Request,
        domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", "domains", domain.rawValue, "credentials"]
        )
        try Mailgun.HTTP.Construction.form(
            request,
            encoder: .mailgunLiteralBool,
            into: &httpRequest
        )
        return httpRequest
    }

    public static func deleteAll(
        domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", "domains", domain.rawValue, "credentials"]
        )
    }

    public static func update(
        _ login: String,
        _ request: Mailgun.Credentials.Update.Request,
        domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", "domains", domain.rawValue, "credentials", login]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func delete(
        _ login: String,
        domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", "domains", domain.rawValue, "credentials", login]
        )
    }

    /// Addresses `/v3/{domain}/mailboxes/{login}` — no `domains` path segment,
    /// matching the archived router (a documented irregularity, not a typo).
    public static func updateMailbox(
        _ login: String,
        _ request: Mailgun.Credentials.Mailbox.Update.Request,
        domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", domain.rawValue, "mailboxes", login]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }
}
