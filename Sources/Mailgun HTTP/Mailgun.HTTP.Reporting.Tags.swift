import Domain_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Reporting.Tags` (docs
/// section "Tags").
///
/// Ported from the archived `Mailgun Reporting Types/Tags/Tags.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Reporting.Tags.txt`. `limits`
/// addresses `/v3/domains/{domain}/limits/tag` — the only operation here
/// with a `domains` literal path segment; every other operation addresses
/// `/v3/{domain}/tag...` directly.
extension Mailgun.HTTP.Reporting {
    public enum Tags: Sendable {}
}

extension Mailgun.HTTP.Reporting.Tags {
    public static func list(
        _ domain: Domain,
        _ request: Mailgun.Reporting.Tags.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let page = request?.page { query.append(("page", page)) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "tags"],
            query: query
        )
    }

    public static func get(
        _ domain: Domain,
        tag: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "tag"],
            query: [("tag", tag)]
        )
    }

    public static func update(
        _ domain: Domain,
        tag: String,
        _ request: Mailgun.Reporting.Tags.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", domain.rawValue, "tag"],
            query: [("tag", tag), ("description", request.description)]
        )
    }

    public static func delete(
        _ domain: Domain,
        tag: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", domain.rawValue, "tag"],
            query: [("tag", tag)]
        )
    }

    public static func stats(
        _ domain: Domain,
        tag: String,
        _ request: Mailgun.Reporting.Tags.Stats.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = [
            ("tag", tag),
            ("event", request.event.joined(separator: ",")),
        ]
        if let start = request.start { query.append(("start", start)) }
        if let end = request.end { query.append(("end", end)) }
        if let resolution = request.resolution { query.append(("resolution", resolution)) }
        if let duration = request.duration { query.append(("duration", duration)) }
        if let provider = request.provider { query.append(("provider", provider)) }
        if let device = request.device { query.append(("device", device)) }
        if let country = request.country { query.append(("country", country)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "tag", "stats"],
            query: query
        )
    }

    public static func aggregates(
        _ domain: Domain,
        tag: String,
        _ request: Mailgun.Reporting.Tags.Aggregates.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "tag", "stats", "aggregates"],
            query: [("tag", tag), ("type", request.type)]
        )
    }

    /// Addresses `/v3/domains/{domain}/limits/tag` — the `domains` literal
    /// segment every other operation here omits.
    public static func limits(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", "domains", domain.rawValue, "limits", "tag"]
        )
    }
}
