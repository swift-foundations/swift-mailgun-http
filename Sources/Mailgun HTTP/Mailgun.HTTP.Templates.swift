import Domain_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Templates` (docs section
/// "Templates").
///
/// Ported from the archived `Mailgun Templates Types/Templates.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Templates.txt`. Every mutating
/// operation here uses `multipart/form-data` under the same fixed
/// `----MailgunFormBoundary` boundary as `Routes.update` and `Lists.update` —
/// Templates has no `application/x-www-form-urlencoded` operations at all.
/// Paths address `/v3/{domain}/templates/...` directly — no `domains`
/// literal segment, unlike `Credentials`/`Domains.DKIMSecurity`/etc.
extension Mailgun.HTTP {
    public enum Templates: Sendable {}
}

extension Mailgun.HTTP.Templates {
    public static func list(
        _ domain: Domain,
        _ request: Mailgun.Templates.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let page = request?.page { query.append(("page", page.rawValue)) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        if let p = request?.p { query.append(("p", p)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "templates"],
            query: query
        )
    }

    public static func create(
        _ domain: Domain,
        _ request: Mailgun.Templates.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", domain.rawValue, "templates"]
        )
        let boundary = try Mailgun.HTTP.Construction.boundary("----MailgunFormBoundary")
        try Mailgun.HTTP.Construction.multipart(request, boundary: boundary, into: &httpRequest)
        return httpRequest
    }

    public static func deleteAll(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v3", domain.rawValue, "templates"])
    }

    public static func versions(
        _ domain: Domain,
        _ templateName: String,
        _ request: Mailgun.Templates.Versions.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let page = request?.page { query.append(("page", page.rawValue)) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        if let p = request?.p { query.append(("p", p)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "templates", templateName, "versions"],
            query: query
        )
    }

    public static func createVersion(
        _ domain: Domain,
        _ templateName: String,
        _ request: Mailgun.Templates.Version.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", domain.rawValue, "templates", templateName, "versions"]
        )
        let boundary = try Mailgun.HTTP.Construction.boundary("----MailgunFormBoundary")
        try Mailgun.HTTP.Construction.multipart(request, boundary: boundary, into: &httpRequest)
        return httpRequest
    }

    public static func get(
        _ domain: Domain,
        _ templateName: String,
        _ request: Mailgun.Templates.Get.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let active = request?.active { query.append(("active", active)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "templates", templateName],
            query: query
        )
    }

    public static func update(
        _ domain: Domain,
        _ templateName: String,
        _ request: Mailgun.Templates.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", domain.rawValue, "templates", templateName]
        )
        let boundary = try Mailgun.HTTP.Construction.boundary("----MailgunFormBoundary")
        try Mailgun.HTTP.Construction.multipart(request, boundary: boundary, into: &httpRequest)
        return httpRequest
    }

    public static func delete(
        _ domain: Domain,
        _ templateName: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", domain.rawValue, "templates", templateName]
        )
    }

    public static func getVersion(
        _ domain: Domain,
        _ templateName: String,
        _ versionName: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "templates", templateName, "versions", versionName]
        )
    }

    public static func updateVersion(
        _ domain: Domain,
        _ templateName: String,
        _ versionName: String,
        _ request: Mailgun.Templates.Version.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", domain.rawValue, "templates", templateName, "versions", versionName]
        )
        let boundary = try Mailgun.HTTP.Construction.boundary("----MailgunFormBoundary")
        try Mailgun.HTTP.Construction.multipart(request, boundary: boundary, into: &httpRequest)
        return httpRequest
    }

    public static func deleteVersion(
        _ domain: Domain,
        _ templateName: String,
        _ versionName: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", domain.rawValue, "templates", templateName, "versions", versionName]
        )
    }

    public static func copyVersion(
        _ domain: Domain,
        _ templateName: String,
        _ versionName: String,
        _ newVersionName: String,
        _ request: Mailgun.Templates.Version.Copy.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let comment = request?.comment { query.append(("comment", comment)) }
        return try Mailgun.HTTP.Construction.request(
            .put,
            [
                "v3", domain.rawValue, "templates", templateName, "versions", versionName, "copy",
                newVersionName,
            ],
            query: query
        )
    }
}
