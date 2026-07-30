import HTTP_Standard

/// Wire-level request construction for `Mailgun.Subaccounts` (docs section
/// "Subaccounts").
///
/// Ported from the archived `Mailgun Subaccounts Types/Subaccounts.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Subaccounts.txt`. `delete` addresses
/// the bare `/v5/accounts/subaccounts` collection and carries the target
/// subaccount in an `X-Mailgun-On-Behalf-Of` header rather than the path —
/// not a mistake. `updateFeatures` renders booleans as literal `true`/`false`
/// (`.mailgunLiteralBool`), matching the `Domains`/`Credentials` convention
/// rather than `yes`/`no`.
extension Mailgun.HTTP {
    public enum Subaccounts: Sendable {}
}

extension Mailgun.HTTP.Subaccounts {
    public static func get(
        _ subaccountId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v5", "accounts", "subaccounts", subaccountId]
        )
    }

    public static func list(
        _ request: Mailgun.Subaccounts.List.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let sort = request?.sort { query.append(("sort", sort.rawValue)) }
        if let filter = request?.filter { query.append(("filter", filter)) }
        if let limit = request?.limit { query.append(("limit", String(limit))) }
        if let skip = request?.skip { query.append(("skip", String(skip))) }
        if let enabled = request?.enabled { query.append(("enabled", String(enabled))) }
        if let closed = request?.closed { query.append(("closed", String(closed))) }
        return try Mailgun.HTTP.Construction.request(
            .get,
            ["v5", "accounts", "subaccounts"],
            query: query
        )
    }

    public static func create(
        _ request: Mailgun.Subaccounts.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .post,
            ["v5", "accounts", "subaccounts"],
            query: [("name", request.name)]
        )
    }

    /// Addresses the bare `/v5/accounts/subaccounts` collection; the target
    /// subaccount travels in the `X-Mailgun-On-Behalf-Of` header, not the
    /// path — matching the archived router exactly.
    public static func delete(
        _ subaccountId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .delete,
            ["v5", "accounts", "subaccounts"]
        )
        httpRequest.headers.append(
            try Mailgun.HTTP.Construction.header("X-Mailgun-On-Behalf-Of", subaccountId)
        )
        return httpRequest
    }

    public static func disable(
        _ subaccountId: String,
        _ request: Mailgun.Subaccounts.Disable.Request? = nil
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var query: [(String, String)] = []
        if let reason = request?.reason { query.append(("reason", reason)) }
        if let note = request?.note { query.append(("note", note)) }
        return try Mailgun.HTTP.Construction.request(
            .post,
            ["v5", "accounts", "subaccounts", subaccountId, "disable"],
            query: query
        )
    }

    public static func enable(
        _ subaccountId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .post,
            ["v5", "accounts", "subaccounts", subaccountId, "enable"]
        )
    }

    public static func getCustomLimit(
        _ subaccountId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v5", "accounts", "subaccounts", subaccountId, "limit", "custom", "monthly"]
        )
    }

    public static func updateCustomLimit(
        _ subaccountId: String,
        limit: Double
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .put,
            ["v5", "accounts", "subaccounts", subaccountId, "limit", "custom", "monthly"],
            query: [("limit", String(limit))]
        )
    }

    public static func deleteCustomLimit(
        _ subaccountId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v5", "accounts", "subaccounts", subaccountId, "limit", "custom", "monthly"]
        )
    }

    public static func updateFeatures(
        _ subaccountId: String,
        _ request: Mailgun.Subaccounts.Features.Update.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .put,
            ["v5", "accounts", "subaccounts", subaccountId, "features"]
        )
        try Mailgun.HTTP.Construction.form(
            request,
            encoder: .mailgunLiteralBool,
            into: &httpRequest
        )
        return httpRequest
    }
}
