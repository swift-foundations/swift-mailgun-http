import Domain_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Reporting.Stats` (docs
/// section "Stats").
///
/// Ported from the archived `Mailgun Reporting Types/Stats/Stats.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Reporting.Stats.txt`.
extension Mailgun.HTTP.Reporting {
    public enum Stats: Sendable {}
}

extension Mailgun.HTTP.Reporting.Stats {
    public static func total(
        _ request: Mailgun.Reporting.Stats.Total.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = [("event", request.event)]
        if let start = request.start { query.append(("start", start)) }
        if let end = request.end { query.append(("end", end)) }
        if let resolution = request.resolution { query.append(("resolution", resolution)) }
        if let duration = request.duration { query.append(("duration", duration)) }
        return try Mailgun.HTTP.Construction.request(.get, ["v3", "stats", "total"], query: query)
    }

    public static func filter(
        _ request: Mailgun.Reporting.Stats.Filter.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = [("event", request.event)]
        if let start = request.start { query.append(("start", start)) }
        if let end = request.end { query.append(("end", end)) }
        if let resolution = request.resolution { query.append(("resolution", resolution)) }
        if let duration = request.duration { query.append(("duration", duration)) }
        if let filter = request.filter { query.append(("filter", filter)) }
        if let group = request.group { query.append(("group", group)) }
        return try Mailgun.HTTP.Construction.request(.get, ["v3", "stats", "filter"], query: query)
    }

    public static func aggregateProviders(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "aggregates", "providers"]
        )
    }

    public static func aggregateDevices(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "aggregates", "devices"]
        )
    }

    public static func aggregateCountries(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "aggregates", "countries"]
        )
    }
}
