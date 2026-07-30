import HTTP_Standard

/// Wire-level request construction for `Mailgun.DynamicIPPools` (docs section
/// "Dynamic IP Pools").
///
/// Ported from the archived `Mailgun IPPools Types/Dynamic IP Pools/DynamicIPPools API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/IPPools.Dynamic.txt`. `listHistory`'s
/// limit query parameter is capitalized (`Limit=`), matching the archived
/// router exactly — not a typo. `removeOverride` addresses a plain `String`
/// domain, matching the archived router's untyped path parameter.
extension Mailgun.HTTP.IPPools {
    public enum Dynamic: Sendable {}
}

extension Mailgun.HTTP.IPPools.Dynamic {
    public static func listHistory(
        _ request: Mailgun.DynamicIPPools.HistoryList.Request = .init()
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let limit = request.limit { query.append(("Limit", String(limit))) }
        if let includeSubaccounts = request.includeSubaccounts {
            query.append(("include_subaccounts", String(includeSubaccounts)))
        }
        if let domain = request.domain { query.append(("domain", domain)) }
        if let before = request.before { query.append(("before", before)) }
        if let after = request.after { query.append(("after", after)) }
        if let movedTo = request.movedTo { query.append(("moved_to", movedTo)) }
        if let movedFrom = request.movedFrom { query.append(("moved_from", movedFrom)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v1", "dynamic_pools", "history"],
            query: query
        )
    }

    public static func removeOverride(
        domain: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v1", "dynamic_pools", "domains", domain, "override"]
        )
    }
}
