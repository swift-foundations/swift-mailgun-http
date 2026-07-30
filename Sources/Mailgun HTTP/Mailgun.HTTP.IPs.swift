import Domain_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.IPs` (docs section "IPs").
///
/// Ported from the archived `Mailgun IPs Types/IPs/IPs API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/IPs.txt`. `deleteDomainIP` and
/// `deleteDomainPool` address `/v3/domains/{domain}/...`, unlike every other
/// operation here which addresses `/v3/ips/...` directly.
extension Mailgun.HTTP {
    public enum IPs: Sendable {}
}

extension Mailgun.HTTP.IPs {
    public static func list() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v3", "ips"])
    }

    public static func get(
        _ ip: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v3", "ips", ip])
    }

    public static func listDomains(
        _ ip: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v3", "ips", ip, "domains"])
    }

    public static func assignDomain(
        _ ip: String,
        _ request: Mailgun.IPs.AssignDomain.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", "ips", ip, "domains"]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func unassignDomain(
        _ ip: String,
        domain: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v3", "ips", ip, "domains", domain])
    }

    public static func assignIPBand(
        _ ip: String,
        _ request: Mailgun.IPs.IPBand.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", "ips", ip, "ip_band"]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func requestNew(
        _ request: Mailgun.IPs.RequestNew.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", "ips", "request", "new"]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func getRequestedIPs() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v3", "ips", "request", "new"])
    }

    public static func deleteDomainIP(
        domain: Domain,
        ip: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", "domains", domain.rawValue, "ips", ip]
        )
    }

    public static func deleteDomainPool(
        domain: Domain,
        ip: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", "domains", domain.rawValue, "pool", ip]
        )
    }
}
