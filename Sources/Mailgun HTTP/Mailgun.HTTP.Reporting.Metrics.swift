import HTTP_Standard

/// Wire-level request construction for `Mailgun.Reporting.Metrics` (docs
/// section "Account Metrics").
///
/// Ported from the archived `Mailgun Reporting Types/Metrics/Metrics.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Reporting.Metrics.txt`. Unlike
/// `Reporting.Logs.analytics`, both request DTOs here carry only plain
/// `String`/`Bool`/`[String]` fields (no `Time.Epoch`), so each is passed
/// straight through `Mailgun.HTTP.Construction.json(_:into:)` — the DTO's
/// own `Codable` conformance is already wire-accurate.
extension Mailgun.HTTP.Reporting {
    public enum Metrics: Sendable {}
}

extension Mailgun.HTTP.Reporting.Metrics {
    public static func getAccountMetrics(
        _ request: Mailgun.Reporting.Metrics.GetAccountMetrics.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v1", "analytics", "metrics"]
        )
        try Mailgun.HTTP.Construction.json(request, into: &httpRequest)
        return httpRequest
    }

    public static func getAccountUsageMetrics(
        _ request: Mailgun.Reporting.Metrics.GetAccountUsageMetrics.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v1", "analytics", "usage", "metrics"]
        )
        try Mailgun.HTTP.Construction.json(request, into: &httpRequest)
        return httpRequest
    }
}
