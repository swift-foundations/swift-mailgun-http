import HTTP_Standard

/// Wire-level request construction for `Mailgun.Domains.DomainKeys` (docs
/// section "Domain Keys").
///
/// Ported from the archived `Mailgun Domains Types/Domain Keys/Domain Keys.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Domains.Keys.txt`. `activate`,
/// `listDomainKeys`, and `deactivate` address `/v4/domains/{authorityName}/keys/...`
/// with a bare `String` authority name — the archived router parses it as a
/// plain string, not a `Domain`, matching this port.
extension Mailgun.HTTP.Domains {
    public enum Keys: Sendable {}
}

extension Mailgun.HTTP.Domains.Keys {
    public static func list(
        _ request: Mailgun.Domains.DomainKeys.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let page = request?.page { query.append(("page", page)) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        if let signingDomain = request?.signingDomain {
            query.append(("signing_domain", signingDomain))
        }
        if let selector = request?.selector { query.append(("selector", selector)) }
        return try Mailgun.HTTP.Construction.request(.get, ["v1", "dkim", "keys"], query: query)
    }

    public static func create(
        _ request: Mailgun.Domains.DomainKeys.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.post, ["v1", "dkim", "keys"])
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func delete(
        _ request: Mailgun.Domains.DomainKeys.Delete.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.delete, ["v1", "dkim", "keys"])
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func activate(
        authorityName: String,
        selector: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .put,
            ["v4", "domains", authorityName, "keys", selector, "activate"]
        )
    }

    public static func listDomainKeys(
        authorityName: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v4", "domains", authorityName, "keys"])
    }

    public static func deactivate(
        authorityName: String,
        selector: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .put,
            ["v4", "domains", authorityName, "keys", selector, "deactivate"]
        )
    }

    public static func setDkimAuthority(
        domainName: String,
        _ request: Mailgun.Domains.DomainKeys.SetDkimAuthority.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", "domains", domainName, "dkim_authority"]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func setDkimSelector(
        domainName: String,
        _ request: Mailgun.Domains.DomainKeys.SetDkimSelector.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", "domains", domainName, "dkim_selector"]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }
}
