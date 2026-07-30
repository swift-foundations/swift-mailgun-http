import Domain_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Domains.Domains` (official
/// reference: `.../send/mailgun/domains`) — domain CRUD.
///
/// Ported from the archived `Mailgun Domains Types/Domains/Domains Domains API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Domains.txt`. The DKIM security,
/// domain keys, and domain tracking sub-resources live in their own
/// `Mailgun.HTTP.Domains.DKIMSecurity`, `.Keys`, and `.Tracking` namespaces.
extension Mailgun.HTTP {
    public enum Domains: Sendable {}
}

extension Mailgun.HTTP.Domains {
    public static func list(
        _ request: Mailgun.Domains.Domains.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let authority = request?.authority { query.append(("authority", authority)) }
        if let state = request?.state { query.append(("state", state.rawValue)) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        if let skip = request?.skip { query.append(("skip", String(skip))) }
        return try Mailgun.HTTP.Construction.request(.get, ["v4", "domains"], query: query)
    }

    public static func create(
        _ request: Mailgun.Domains.Domains.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.post, ["v4", "domains"])
        try Mailgun.HTTP.Construction.form(
            request,
            encoder: .mailgunLiteralBool,
            into: &httpRequest
        )
        return httpRequest
    }

    public static func get(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v4", "domains", domain.rawValue])
    }

    public static func update(
        _ domain: Domain,
        _ request: Mailgun.Domains.Domains.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v4", "domains", domain.rawValue]
        )
        try Mailgun.HTTP.Construction.form(
            request,
            encoder: .mailgunLiteralBool,
            into: &httpRequest
        )
        return httpRequest
    }

    public static func delete(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v4", "domains", domain.rawValue])
    }

    public static func verify(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.put, ["v4", "domains", domain.rawValue, "verify"])
    }
}
