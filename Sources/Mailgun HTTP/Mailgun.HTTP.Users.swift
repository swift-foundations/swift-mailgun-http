import HTTP_Standard

/// Wire-level request construction for `Mailgun.Users` (docs section
/// "Users").
///
/// Ported from the archived `Mailgun Users Types/Users.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Users.txt`.
extension Mailgun.HTTP {
    public enum Users: Sendable {}
}

extension Mailgun.HTTP.Users {
    public static func list(
        _ request: Mailgun.Users.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let role = request?.role { query.append(("role", role.rawValue)) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        if let skip = request?.skip { query.append(("skip", String(skip))) }
        return try Mailgun.HTTP.Construction.request(.get, ["v5", "users"], query: query)
    }

    public static func get(
        _ userId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v5", "users", userId])
    }

    public static func me() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v5", "users", "me"])
    }

    public static func addToOrganization(
        userId: String,
        orgId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.put, ["v5", "users", userId, "org", orgId])
    }

    public static func removeFromOrganization(
        userId: String,
        orgId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v5", "users", userId, "org", orgId])
    }
}
