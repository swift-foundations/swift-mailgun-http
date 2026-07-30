import HTTP_Standard

/// Wire-level request construction for `Mailgun.IPAddressWarmup` (docs
/// section "IP Address Warmup").
///
/// Ported from the archived `Mailgun IPs Types/IP Address Warmup/IPAddressWarmup API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/IPs.Warmup.txt`. `create`'s `enabled`
/// field renders as literal `true`/`false` (`.mailgunLiteralBool`), matching
/// `Domains`/`Domains.Tracking`/`Domains.DKIMSecurity`/`Credentials` rather
/// than the `yes`/`no` `.mailgun` default.
extension Mailgun.HTTP.IPs {
    public enum Warmup: Sendable {}
}

extension Mailgun.HTTP.IPs.Warmup {
    public static func list() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v3", "ip_warmups"])
    }

    public static func get(
        _ ip: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v3", "ip_warmups", ip])
    }

    public static func create(
        _ ip: String,
        _ request: Mailgun.IPAddressWarmup.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.post, ["v3", "ip_warmups", ip])
        try Mailgun.HTTP.Construction.form(
            request,
            encoder: .mailgunLiteralBool,
            into: &httpRequest
        )
        return httpRequest
    }

    public static func delete(
        _ ip: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v3", "ip_warmups", ip])
    }
}
