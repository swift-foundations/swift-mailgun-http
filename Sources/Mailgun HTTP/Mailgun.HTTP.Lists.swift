import EmailAddress_Standard
import HTTP_Standard

/// Wire-level request construction for `Mailgun.Lists` (official reference:
/// `.../send/mailgun/mailing-lists`).
///
/// Ported from the archived `Mailgun Lists Types/Lists.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Lists.txt`. `bulkAdd`'s array-of-members
/// body renders each element as `[][field]=value` with `subscribed` as literal
/// `true`/`false` (`.mailgunBracketedLiteralBool`) even though
/// `addMember`/`updateMember` on the same resource render their booleans as
/// `yes`/`no` (`.mailgun`) — the corpus is authoritative per operation here,
/// not even uniformly per resource.
///
/// `bulkAddCSV` is not ported: the archived router encodes the CSV payload as
/// a raw `Data`-typed *path* component (not a body), which both fails
/// `Mailgun.HTTP.Construction.path`'s RFC 3986 segment-legality check for any
/// payload containing the row-separating newline the operation exists to
/// carry, and is not fully captured by its own corpus fixture (the fixture's
/// line-oriented `path:` field silently truncates at the first embedded
/// newline, dropping the row data entirely — `csv@parity.example.com,CSV Member`
/// is never compared). Recorded as a gap rather than inventing a body shape
/// with no corpus fixture to verify it against.
extension Mailgun.HTTP {
    public enum Lists: Sendable {}
}

extension Mailgun.HTTP.Lists {
    public static func create(
        _ request: Mailgun.Lists.List.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.post, ["v3", "lists"])
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func list(
        _ request: Mailgun.Lists.List.Request = .init()
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let limit = request.limit { query.append(("limit", String(limit))) }
        if let skip = request.skip { query.append(("skip", String(skip))) }
        if let address = request.address { query.append(("address", address.rawValue)) }
        return try Mailgun.HTTP.Construction.request(.get, ["v3", "lists"], query: query)
    }

    public static func members(
        _ listAddress: EmailAddress,
        _ request: Mailgun.Lists.List.Members.Request = .init()
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let address = request.address { query.append(("address", address.rawValue)) }
        if let subscribed = request.subscribed { query.append(("subscribed", String(subscribed))) }
        if let limit = request.limit { query.append(("limit", String(limit))) }
        if let skip = request.skip { query.append(("skip", String(skip))) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", "lists", listAddress.rawValue, "members"],
            query: query
        )
    }

    public static func addMember(
        _ listAddress: EmailAddress,
        _ request: Mailgun.Lists.Member.Add.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", "lists", listAddress.rawValue, "members"]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func bulkAdd(
        _ listAddress: EmailAddress,
        _ members: [Mailgun.Lists.Member.Bulk],
        upsert: Bool? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let upsert { query.append(("upsert", String(upsert))) }
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", "lists", listAddress.rawValue, "members.json"],
            query: query
        )
        try Mailgun.HTTP.Construction.form(
            members,
            encoder: .mailgunBracketedLiteralBool,
            into: &httpRequest
        )
        return httpRequest
    }

    public static func getMember(
        _ listAddress: EmailAddress,
        _ memberAddress: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", "lists", listAddress.rawValue, "members", memberAddress.rawValue]
        )
    }

    public static func updateMember(
        _ listAddress: EmailAddress,
        _ memberAddress: EmailAddress,
        _ request: Mailgun.Lists.Member.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", "lists", listAddress.rawValue, "members", memberAddress.rawValue]
        )
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func deleteMember(
        _ listAddress: EmailAddress,
        _ memberAddress: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v3", "lists", listAddress.rawValue, "members", memberAddress.rawValue]
        )
    }

    public static func update(
        _ listAddress: EmailAddress,
        _ request: Mailgun.Lists.List.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v3", "lists", listAddress.rawValue]
        )
        let boundary = try Mailgun.HTTP.Construction.boundary("----MailgunFormBoundary")
        try Mailgun.HTTP.Construction.multipart(request, boundary: boundary, into: &httpRequest)
        return httpRequest
    }

    public static func delete(
        _ listAddress: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v3", "lists", listAddress.rawValue])
    }

    public static func get(
        _ listAddress: EmailAddress
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v3", "lists", listAddress.rawValue])
    }

    public static func pages(
        limit: Int? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let limit { query.append(("limit", String(limit))) }
        return try Mailgun.HTTP.Construction.request(.get, ["v3", "lists", "pages"], query: query)
    }

    public static func memberPages(
        _ listAddress: EmailAddress,
        _ request: Mailgun.Lists.List.Members.Pages.Request = .init()
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let subscribed = request.subscribed { query.append(("subscribed", String(subscribed))) }
        if let limit = request.limit { query.append(("limit", String(limit))) }
        if let address = request.address { query.append(("address", address.rawValue)) }
        if let page = request.page { query.append(("page", page.rawValue)) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", "lists", listAddress.rawValue, "members", "pages"],
            query: query
        )
    }
}
