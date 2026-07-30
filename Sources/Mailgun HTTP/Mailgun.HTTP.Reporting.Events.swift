import Domain_Standard
import EmailAddress_Standard
import HTTP_Standard
import Time_Primitive

/// Wire-level request construction for `Mailgun.Reporting.Events` (docs
/// section "Events").
///
/// Ported from the archived `Mailgun Reporting Types/Events/Events.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Reporting.Events.txt`. `begin`/`end`
/// render as Unix-epoch-seconds integers; `recipients`/`tags` render as
/// comma-joined lists — none of these go through `HTML.Form.Coder` (this
/// operation carries no body), so each is built directly.
extension Mailgun.HTTP.Reporting {
    public enum Events: Sendable {}
}

extension Mailgun.HTTP.Reporting.Events {
    public static func list(
        _ domain: Domain,
        _ query: Mailgun.Reporting.Events.List.Query? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var parameters: [(String, String)] = []
        if let begin = query?.begin {
            parameters.append(("begin", String(begin.referenceDate.secondsSinceEpoch)))
        }
        if let end = query?.end {
            parameters.append(("end", String(end.referenceDate.secondsSinceEpoch)))
        }
        if let ascending = query?.ascending { parameters.append(("ascending", ascending.rawValue)) }
        if let limit = query?.limit { parameters.append(("limit", String(limit))) }
        if let event = query?.event { parameters.append(("event", event.rawValue)) }
        if let list = query?.list { parameters.append(("list", list)) }
        if let attachment = query?.attachment { parameters.append(("attachment", attachment)) }
        if let from = query?.from { parameters.append(("from", from.rawValue)) }
        if let messageId = query?.messageId { parameters.append(("message-id", messageId)) }
        if let subject = query?.subject { parameters.append(("subject", subject)) }
        if let to = query?.to { parameters.append(("to", to.rawValue)) }
        if let size = query?.size { parameters.append(("size", String(size))) }
        if let recipient = query?.recipient { parameters.append(("recipient", recipient.rawValue)) }
        if let recipients = query?.recipients {
            parameters.append(("recipients", recipients.map(\.rawValue).joined(separator: ",")))
        }
        if let tags = query?.tags { parameters.append(("tags", tags.joined(separator: ","))) }
        if let severity = query?.severity { parameters.append(("severity", severity.rawValue)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "events"],
            query: parameters
        )
    }
}
