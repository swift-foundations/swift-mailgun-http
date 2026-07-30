import HTTP_Standard

/// Wire-level request construction for `Mailgun.Routes` (official reference:
/// `.../send/mailgun/routes`).
///
/// Ported from the archived `Mailgun Routes Types/Routes.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Routes.txt`.
extension Mailgun.HTTP {
    public enum Routes: Sendable {}
}

extension Mailgun.HTTP.Routes {
    public static func create(
        _ request: Mailgun.Routes.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.post, ["v3", "routes"])
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func list(
        limit: Int? = nil,
        skip: Int? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let limit { query.append(("limit", String(limit))) }
        if let skip { query.append(("skip", String(skip))) }
        return try Mailgun.HTTP.Construction.request(.get, ["v3", "routes"], query: query)
    }

    public static func get(
        _ id: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v3", "routes", id])
    }

    public static func update(
        _ id: String,
        _ request: Mailgun.Routes.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.put, ["v3", "routes", id])
        let boundary = try Mailgun.HTTP.Construction.boundary("----MailgunFormBoundary")
        try Mailgun.HTTP.Construction.multipart(request, boundary: boundary, into: &httpRequest)
        return httpRequest
    }

    public static func delete(
        _ id: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v3", "routes", id])
    }

    public static func match(
        _ address: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", "routes", "match"],
            query: [("address", address)]
        )
    }
}
