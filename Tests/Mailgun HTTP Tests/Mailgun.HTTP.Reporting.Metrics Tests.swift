import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Reporting.Metrics {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Reporting.Metrics.Construction.Unit {
    @Test func `getAccountMetrics builds the corpus getAccountMetrics request`() throws {
        let request = try Mailgun.HTTP.Reporting.Metrics.getAccountMetrics(
            .init(
                start: "Mon, 13 Nov 2023 00:00:00 +0000",
                end: "Tue, 14 Nov 2023 00:00:00 +0000",
                resolution: "day",
                duration: "1d",
                dimensions: ["domain"],
                metrics: ["accepted_count", "delivered_count"],
                filter: .init(
                    and: [
                        .init(
                            attribute: "domain",
                            comparator: "=",
                            values: [.init(label: "parity.example.com", value: "parity.example.com")]
                        )
                    ]
                ),
                includeSubaccounts: true,
                includeAggregates: false
            )
        )
        Corpus.load("Reporting.Metrics", case: "getAccountMetrics").expect(matches: request)
    }

    @Test func `getAccountUsageMetrics builds the corpus getAccountUsageMetrics request`() throws {
        let request = try Mailgun.HTTP.Reporting.Metrics.getAccountUsageMetrics(
            .init(
                start: "Mon, 13 Nov 2023 00:00:00 +0000",
                end: "Tue, 14 Nov 2023 00:00:00 +0000",
                resolution: "day",
                duration: "1d",
                dimensions: ["subaccount"],
                metrics: ["email_validation_count"],
                filter: .init(
                    and: [
                        .init(
                            attribute: "domain",
                            comparator: "=",
                            values: [.init(label: "parity.example.com", value: "parity.example.com")]
                        )
                    ]
                ),
                includeSubaccounts: false,
                includeAggregates: true
            )
        )
        Corpus.load("Reporting.Metrics", case: "getAccountUsageMetrics").expect(matches: request)
    }
}
