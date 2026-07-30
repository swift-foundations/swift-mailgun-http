import HTTP_Standard
import Time_Primitive

/// Wire-level request construction for `Mailgun.Reporting.Logs` (docs
/// section "Log Analytics").
///
/// Ported from the archived `Mailgun Reporting Types/Logs/Logs.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Reporting.Logs.txt`. The only
/// `application/json` operation in this package whose request DTO carries a
/// `Time.Epoch` field — `startDate`/`endDate` render as bare Unix-epoch-seconds
/// integers on the wire, not the nested object `Time.Epoch`'s own `Codable`
/// conformance produces, so the body is built as a
/// `Mailgun.HTTP.Construction.JSON` tree rather than passing the DTO straight
/// through `Foundation.JSONEncoder`.
extension Mailgun.HTTP.Reporting {
    public enum Logs: Sendable {}
}

extension Mailgun.HTTP.Reporting.Logs {
    public static func analytics(
        _ request: Mailgun.Reporting.Logs.Analytics.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.post, ["v1", "analytics", "logs"])
        try Mailgun.HTTP.Construction.json(Self.json(request), into: &httpRequest)
        return httpRequest
    }
}

extension Mailgun.HTTP.Reporting.Logs {
    fileprivate static func json(
        _ request: Mailgun.Reporting.Logs.Analytics.Request
    ) -> Mailgun.HTTP.Construction.JSON {
        var pairs: [(String, Mailgun.HTTP.Construction.JSON)] = []
        if let action = request.action { pairs.append(("action", .string(action))) }
        if let groupBy = request.groupBy { pairs.append(("group_by", .string(groupBy))) }
        if let startDate = request.startDate {
            pairs.append(("start_date", .int(startDate.referenceDate.secondsSinceEpoch)))
        }
        if let endDate = request.endDate {
            pairs.append(("end_date", .int(endDate.referenceDate.secondsSinceEpoch)))
        }
        if let filter = request.filter { pairs.append(("filter", Self.json(filter))) }
        if let include = request.include {
            pairs.append(("include", .array(include.map { .string($0.rawValue) })))
        }
        if let page = request.page { pairs.append(("page", Self.json(page))) }
        return .object(pairs)
    }

    fileprivate static func json(
        _ filter: Mailgun.Reporting.Logs.Analytics.Filter
    ) -> Mailgun.HTTP.Construction.JSON {
        var pairs: [(String, Mailgun.HTTP.Construction.JSON)] = []
        if let and = filter.and { pairs.append(("and", .array(and.map(Self.json)))) }
        if let or = filter.or { pairs.append(("or", .array(or.map(Self.json)))) }
        return .object(pairs)
    }

    fileprivate static func json(
        _ condition: Mailgun.Reporting.Logs.Analytics.Condition
    ) -> Mailgun.HTTP.Construction.JSON {
        .object([
            ("field", .string(condition.field)),
            ("operator", .string(condition.operator.rawValue)),
            ("value", Self.json(condition.value)),
        ])
    }

    fileprivate static func json(
        _ value: Mailgun.Reporting.Logs.Analytics.Value
    ) -> Mailgun.HTTP.Construction.JSON {
        switch value {
        case .string(let value): .string(value)
        case .int(let value): .int(value)
        case .double(let value): .double(value)
        case .bool(let value): .bool(value)
        case .array(let value): .array(value.map { .string($0) })
        }
    }

    fileprivate static func json(
        _ page: Mailgun.Reporting.Logs.Analytics.Page
    ) -> Mailgun.HTTP.Construction.JSON {
        var pairs: [(String, Mailgun.HTTP.Construction.JSON)] = []
        if let size = page.size { pairs.append(("size", .int(size))) }
        if let number = page.number { pairs.append(("number", .int(number))) }
        if let sort = page.sort { pairs.append(("sort", .string(sort))) }
        return .object(pairs)
    }
}
