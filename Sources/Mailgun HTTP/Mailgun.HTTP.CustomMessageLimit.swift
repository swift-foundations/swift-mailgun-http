import HTTP_Standard

/// Wire-level request construction for `Mailgun.CustomMessageLimit` (docs
/// section "Custom Message Limit").
///
/// Ported from the archived `Mailgun CustomMessageLimit Types/CustomMessageLimit.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/CustomMessageLimit.txt`.
extension Mailgun.HTTP {
    public enum CustomMessageLimit: Sendable {}
}

extension Mailgun.HTTP.CustomMessageLimit {
    public static func getMonthlyLimit() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v5", "accounts", "limit", "custom", "monthly"]
        )
    }

    public static func setMonthlyLimit(
        _ request: Mailgun.CustomMessageLimit.Monthly.Set.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .put,
            ["v5", "accounts", "limit", "custom", "monthly"],
            query: [("limit", String(request.limit))]
        )
    }

    public static func deleteMonthlyLimit() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request
    {
        try Mailgun.HTTP.Construction.request(
            .delete,
            ["v5", "accounts", "limit", "custom", "monthly"]
        )
    }

    public static func enableAccount() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .put,
            ["v5", "accounts", "limit", "custom", "enable"]
        )
    }
}
