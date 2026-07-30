import HTTP_Standard

/// Wire-level request construction for `Mailgun.IPAllowlist` (docs section
/// "IP Allowlist").
///
/// Ported from the archived `Mailgun IPAllowlist Types/IPAllowlist.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/IPAllowlist.txt`.
extension Mailgun.HTTP {
    public enum IPAllowlist: Sendable {}
}

extension Mailgun.HTTP.IPAllowlist {
    public static func list() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v2", "ip_allowlist"])
    }

    public static func update(
        _ request: Mailgun.IPAllowlist.UpdateRequest
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.put, ["v2", "ip_allowlist"])
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func add(
        _ request: Mailgun.IPAllowlist.AddRequest
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.post, ["v2", "ip_allowlist"])
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func delete(
        _ request: Mailgun.IPAllowlist.DeleteRequest
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.delete, ["v2", "ip_allowlist"])
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }
}
