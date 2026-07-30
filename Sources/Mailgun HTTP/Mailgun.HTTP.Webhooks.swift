import Domain_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Webhooks` (official reference:
/// `.../send/mailgun/domain-webhooks`) — domain-level webhooks.
///
/// Ported from the archived `Mailgun Webhooks Types/Webhooks.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Webhooks.txt`. `url` renders as
/// `url[]=...` (bracketed array), unlike most other resources' repeated bare
/// key — the corpus fixture is authoritative for this per-resource choice.
extension Mailgun.HTTP {
    public enum Webhooks: Sendable {}
}

extension Mailgun.HTTP.Webhooks {
    public static func list(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v3", "domains", domain.rawValue, "webhooks"])
    }

    public static func get(
        _ webhookName: Mailgun.Webhooks.WebhookType,
        domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", "domains", domain.rawValue, "webhooks", webhookName.rawValue]
        )
    }

    public static func create(
        _ request: Mailgun.Webhooks.Create.Request,
        domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", "domains", domain.rawValue, "webhooks"]
        )
        try Mailgun.HTTP.Construction.form(request, encoder: .mailgunBracketed, into: &httpRequest)
        return httpRequest
    }

    public static func update(
        _ webhookName: Mailgun.Webhooks.WebhookType,
        _ request: Mailgun.Webhooks.Update.Request,
        domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", "domains", domain.rawValue, "webhooks", webhookName.rawValue]
        )
        try Mailgun.HTTP.Construction.form(request, encoder: .mailgunBracketed, into: &httpRequest)
        return httpRequest
    }

    public static func delete(
        _ webhookName: Mailgun.Webhooks.WebhookType,
        domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", "domains", domain.rawValue, "webhooks", webhookName.rawValue]
        )
    }
}
