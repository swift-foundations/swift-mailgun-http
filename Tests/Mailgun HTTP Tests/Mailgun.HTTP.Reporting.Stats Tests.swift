import Domain_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Reporting.Stats {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Reporting.Stats.Construction.Unit {
    @Test func `total builds the corpus total request`() throws {
        let request = try Mailgun.HTTP.Reporting.Stats.total(
            .init(
                event: "delivered",
                start: "Mon, 13 Nov 2023 00:00:00 +0000",
                end: "Tue, 14 Nov 2023 00:00:00 +0000",
                resolution: "day",
                duration: "1d"
            )
        )
        Corpus.load("Reporting.Stats", case: "total").expect(matches: request)
    }

    @Test func `total with only event builds the corpus total.minimal request`() throws {
        let request = try Mailgun.HTTP.Reporting.Stats.total(.init(event: "accepted"))
        Corpus.load("Reporting.Stats", case: "total.minimal").expect(matches: request)
    }

    @Test func `filter builds the corpus filter request`() throws {
        let request = try Mailgun.HTTP.Reporting.Stats.filter(
            .init(
                event: "delivered",
                start: "Mon, 13 Nov 2023 00:00:00 +0000",
                end: "Tue, 14 Nov 2023 00:00:00 +0000",
                resolution: "day",
                duration: "1d",
                filter: "domain=parity.example.com",
                group: "domain"
            )
        )
        Corpus.load("Reporting.Stats", case: "filter").expect(matches: request)
    }

    @Test func `aggregateProviders builds the corpus aggregateProviders request`() throws {
        let request = try Mailgun.HTTP.Reporting.Stats.aggregateProviders(
            try Domain("parity.example.com")
        )
        Corpus.load("Reporting.Stats", case: "aggregateProviders").expect(matches: request)
    }

    @Test func `aggregateDevices builds the corpus aggregateDevices request`() throws {
        let request = try Mailgun.HTTP.Reporting.Stats.aggregateDevices(
            try Domain("parity.example.com")
        )
        Corpus.load("Reporting.Stats", case: "aggregateDevices").expect(matches: request)
    }

    @Test func `aggregateCountries builds the corpus aggregateCountries request`() throws {
        let request = try Mailgun.HTTP.Reporting.Stats.aggregateCountries(
            try Domain("parity.example.com")
        )
        Corpus.load("Reporting.Stats", case: "aggregateCountries").expect(matches: request)
    }
}
