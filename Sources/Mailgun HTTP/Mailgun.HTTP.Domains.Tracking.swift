import Domain_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Domains.Domains.Tracking`
/// (docs section "Tracking").
///
/// Ported from the archived `Mailgun Domains Types/Domain Tracking/Domain Tracking.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Domains.Tracking.txt`.
extension Mailgun.HTTP.Domains {
    public enum Tracking: Sendable {}
}

extension Mailgun.HTTP.Domains.Tracking {
    public static func get(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v3", "domains", domain.rawValue, "tracking"])
    }

    public static func updateClick(
        _ domain: Domain,
        _ request: Mailgun.Domains.Domains.Tracking.UpdateClick.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", "domains", domain.rawValue, "tracking", "click"]
        )
        try Mailgun.HTTP.Construction.form(
            request,
            encoder: .mailgunLiteralBool,
            into: &httpRequest
        )
        return httpRequest
    }

    public static func updateOpen(
        _ domain: Domain,
        _ request: Mailgun.Domains.Domains.Tracking.UpdateOpen.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", "domains", domain.rawValue, "tracking", "open"]
        )
        try Mailgun.HTTP.Construction.form(
            request,
            encoder: .mailgunLiteralBool,
            into: &httpRequest
        )
        return httpRequest
    }

    public static func updateUnsubscribe(
        _ domain: Domain,
        _ request: Mailgun.Domains.Domains.Tracking.UpdateUnsubscribe.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", "domains", domain.rawValue, "tracking", "unsubscribe"]
        )
        try Mailgun.HTTP.Construction.form(
            request,
            encoder: .mailgunLiteralBool,
            into: &httpRequest
        )
        return httpRequest
    }
}
