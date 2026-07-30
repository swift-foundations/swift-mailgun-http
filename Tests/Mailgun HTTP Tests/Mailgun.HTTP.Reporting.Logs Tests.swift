import Testing
import Time_Primitive

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Reporting.Logs {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Reporting.Logs.Construction.Unit {
    @Test func `analytics builds the corpus analytics.full request`() throws {
        let request = try Mailgun.HTTP.Reporting.Logs.analytics(
            .init(
                action: "delivered",
                groupBy: "domain",
                startDate: .init(referenceDate: Time(secondsSinceEpoch: 721_692_800)),
                endDate: .init(referenceDate: Time(secondsSinceEpoch: 721_779_200)),
                filter: .init(
                    and: [
                        .init(
                            field: "domain",
                            operator: .equals,
                            value: .string("parity.example.com")
                        )
                    ],
                    or: [
                        .init(field: "severity", operator: .notEquals, value: .string("temporary"))
                    ]
                ),
                include: [.actions, .total],
                page: .init(size: 50, number: 1, sort: "timestamp:desc")
            )
        )
        Corpus.load("Reporting.Logs", case: "analytics.full").expect(matches: request)
    }

    @Test func `analytics with no fields builds the corpus analytics.empty request`() throws {
        let request = try Mailgun.HTTP.Reporting.Logs.analytics(.init())
        Corpus.load("Reporting.Logs", case: "analytics.empty").expect(matches: request)
    }
}
