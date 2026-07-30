import EmailAddress_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.AccountManagement` (docs
/// section "Account Management").
///
/// Ported from the archived `Mailgun AccountManagement Types/AccountManagement.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/AccountManagement.txt`. Every operation
/// here carries its parameters as query parameters, never a body.
extension Mailgun.HTTP {
    public enum AccountManagement: Sendable {}
}

extension Mailgun.HTTP.AccountManagement {
    public static func updateAccount(
        _ request: Mailgun.AccountManagement.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let name = request.name { query.append(("name", name)) }
        if let value = request.inactiveSessionTimeout {
            query.append(("inactive_session_timeout", String(value)))
        }
        if let value = request.absoluteSessionTimeout {
            query.append(("absolute_session_timeout", String(value)))
        }
        if let value = request.logoutRedirectUrl {
            query.append(("logout_redirect_url", value))
        }
        return try Mailgun.HTTP.Construction.request(.put, ["v5", "accounts"], query: query)
    }

    public static func getHttpSigningKey() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v5", "accounts", "http_signing_key"])
    }

    public static func regenerateHttpSigningKey()
        throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request
    {
        try Mailgun.HTTP.Construction.request(.post, ["v5", "accounts", "http_signing_key"])
    }

    public static func getSandboxAuthRecipients()
        throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request
    {
        try Mailgun.HTTP.Construction.request(.get, ["v5", "sandbox", "auth_recipients"])
    }

    public static func addSandboxAuthRecipient(
        _ request: Mailgun.AccountManagement.Sandbox.Auth.Recipients.Add.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .post,
            ["v5", "sandbox", "auth_recipients"],
            query: [("email", request.email.rawValue)]
        )
    }

    public static func deleteSandboxAuthRecipient(
        _ email: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v5", "sandbox", "auth_recipients", email.rawValue]
        )
    }

    public static func resendActivationEmail()
        throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request
    {
        try Mailgun.HTTP.Construction.request(.post, ["v5", "accounts", "resend_activation_email"])
    }

    public static func getSAMLOrganization() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request
    {
        try Mailgun.HTTP.Construction.request(.get, ["v5", "accounts", "saml_org"])
    }

    public static func addSAMLOrganization(
        _ request: Mailgun.AccountManagement.SAML.Organization.Add.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = [("user_id", request.userId)]
        if let domain = request.domain { query.append(("domain", domain)) }
        return try Mailgun.HTTP.Construction.request(
            .post,
            ["v5", "accounts", "saml_org"],
            query: query
        )
    }
}
