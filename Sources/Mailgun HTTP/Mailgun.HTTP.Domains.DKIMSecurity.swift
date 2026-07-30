import Domain_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Domains.DKIM_Security` (docs
/// section "DKIM Key Rotation").
///
/// Ported from the archived `Mailgun Domains Types/DKIM Security/DKIM Security.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Domains.DKIMSecurity.txt`.
extension Mailgun.HTTP.Domains {
    public enum DKIMSecurity: Sendable {}
}

extension Mailgun.HTTP.Domains.DKIMSecurity {
    public static func updateRotation(
        _ domain: Domain,
        _ request: Mailgun.Domains.DKIM_Security.Rotation.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v1", "dkim_management", "domains", domain.rawValue, "rotation"]
        )
        try Mailgun.HTTP.Construction.form(
            request,
            encoder: .mailgunLiteralBool,
            into: &httpRequest
        )
        return httpRequest
    }

    public static func rotateManually(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .post,
            ["v1", "dkim_management", "domains", domain.rawValue, "rotate"]
        )
    }
}
