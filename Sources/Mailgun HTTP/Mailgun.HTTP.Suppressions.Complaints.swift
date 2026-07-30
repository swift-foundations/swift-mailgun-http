import Domain_Standard
import EmailAddress_Standard
import Foundation
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Suppressions.Complaints`
/// (docs section "Complaints").
///
/// Ported from the archived `Mailgun Suppressions Types/Complaints/Complaints.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Suppressions.Complaints.txt`. Unlike
/// `Bounces`/`Unsubscribe`/`Allowlist`, `importList` here uses the same
/// fixed `----MailgunFormBoundary` boundary as `Routes.update`/`Lists.update`
/// (not a random one), and its `file` field renders as a plain quoted
/// base64 text field — not a `multipart` file attachment. The DTO's
/// `file: [UInt8]` doesn't trigger that rendering by itself: `HTML.Form.Coder`
/// treats a bare `[UInt8]` as any other array (one repeated "file" part per
/// byte, per the default `arrayEncodingStrategy`), only `Foundation.Data`
/// gets base64 treatment, so this re-wraps the bytes as `Data` in a private
/// shadow request before encoding.
extension Mailgun.HTTP.Suppressions {
    public enum Complaints: Sendable {}
}

extension Mailgun.HTTP.Suppressions.Complaints {
    public static func importList(
        _ domain: Domain,
        _ request: Mailgun.Suppressions.Complaints.Import.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", domain.rawValue, "complaints", "import"]
        )
        let boundary = try Mailgun.HTTP.Construction.boundary("----MailgunFormBoundary")
        try Mailgun.HTTP.Construction.multipart(
            Self.ImportBody(file: Data(request.file)),
            boundary: boundary,
            into: &httpRequest
        )
        return httpRequest
    }

    /// Mirrors `Mailgun.Suppressions.Complaints.Import.Request`'s single
    /// `file` field, retyped `Foundation.Data` so it renders as a base64
    /// text part instead of one repeated part per byte. See `importList`.
    fileprivate struct ImportBody: Swift.Codable {
        let file: Foundation.Data
    }

    public static func get(
        _ domain: Domain,
        address: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "complaints", address.rawValue]
        )
    }

    public static func delete(
        _ domain: Domain,
        address: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", domain.rawValue, "complaints", address.rawValue]
        )
    }

    public static func list(
        _ domain: Domain,
        _ request: Mailgun.Suppressions.Complaints.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let address = request?.address { query.append(("address", address.rawValue)) }
        if let term = request?.term { query.append(("term", term)) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        if let page = request?.page { query.append(("page", page)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", domain.rawValue, "complaints"],
            query: query
        )
    }

    public static func create(
        _ domain: Domain,
        _ request: Mailgun.Suppressions.Complaints.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", domain.rawValue, "complaints"]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func deleteAll(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v3", domain.rawValue, "complaints"])
    }
}
