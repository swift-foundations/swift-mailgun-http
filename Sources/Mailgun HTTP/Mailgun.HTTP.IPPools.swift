import HTTP_Standard

/// Wire-level request construction for `Mailgun.IPPools` (docs section "IP
/// Pools").
///
/// Ported from the archived `Mailgun IPPools Types/IP Pools/IPPools API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/IPPools.txt`. `create` and `update`
/// render IP arrays as `ips[]=`/`add_ips[]=`/`remove_ips[]=` (`.mailgunBracketed`),
/// unlike most other resources' repeated bare key. `update` is the one
/// operation in this package that uses `PATCH` rather than `PUT`.
extension Mailgun.HTTP {
    public enum IPPools: Sendable {}
}

extension Mailgun.HTTP.IPPools {
    public static func list() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v1", "ip_pools"])
    }

    public static func create(
        _ request: Mailgun.IPPools.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.post, ["v1", "ip_pools"])
        try Mailgun.HTTP.Construction.form(request, encoder: .mailgunBracketed, into: &httpRequest)
        return httpRequest
    }

    public static func get(
        _ poolId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v1", "ip_pools", poolId])
    }

    public static func update(
        _ poolId: String,
        _ request: Mailgun.IPPools.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.patch, ["v1", "ip_pools", poolId])
        try Mailgun.HTTP.Construction.form(request, encoder: .mailgunBracketed, into: &httpRequest)
        return httpRequest
    }

    public static func delete(
        _ poolId: String,
        _ request: Mailgun.IPPools.Delete.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let ip = request?.ip { query.append(("ip", ip)) }
        if let replacementPoolId = request?.poolId { query.append(("pool_id", replacementPoolId)) }
        return try Mailgun.HTTP.Construction.request(
            .delete,
            ["v1", "ip_pools", poolId],
            query: query
        )
    }

    public static func listDomains(
        _ poolId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v1", "ip_pools", poolId, "domains"])
    }
}
