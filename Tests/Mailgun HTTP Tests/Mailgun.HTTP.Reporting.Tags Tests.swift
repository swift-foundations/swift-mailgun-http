import Domain_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Reporting.Tags {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Reporting.Tags.Construction.Unit {
    @Test func `list builds the corpus list.query request`() throws {
        let request = try Mailgun.HTTP.Reporting.Tags.list(
            try Domain("parity.example.com"),
            .init(page: "next-page-token", limit: 25)
        )
        Corpus.load("Reporting.Tags", case: "list.query").expect(matches: request)
    }

    @Test func `list with no request builds the corpus list.bare request`() throws {
        let request = try Mailgun.HTTP.Reporting.Tags.list(try Domain("parity.example.com"))
        Corpus.load("Reporting.Tags", case: "list.bare").expect(matches: request)
    }

    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Reporting.Tags.get(
            try Domain("parity.example.com"),
            tag: "newsletter"
        )
        Corpus.load("Reporting.Tags", case: "get").expect(matches: request)
    }

    @Test func `update builds the corpus update request`() throws {
        let request = try Mailgun.HTTP.Reporting.Tags.update(
            try Domain("parity.example.com"),
            tag: "newsletter",
            .init(description: "Parity fixture tag")
        )
        Corpus.load("Reporting.Tags", case: "update").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Reporting.Tags.delete(
            try Domain("parity.example.com"),
            tag: "newsletter"
        )
        Corpus.load("Reporting.Tags", case: "delete").expect(matches: request)
    }

    @Test func `stats builds the corpus stats request`() throws {
        let request = try Mailgun.HTTP.Reporting.Tags.stats(
            try Domain("parity.example.com"),
            tag: "newsletter",
            .init(
                event: ["accepted", "delivered"],
                start: "Mon, 13 Nov 2023 00:00:00 +0000",
                end: "Tue, 14 Nov 2023 00:00:00 +0000",
                resolution: "day",
                duration: "1d",
                provider: "gmail.com",
                device: "desktop",
                country: "nl"
            )
        )
        Corpus.load("Reporting.Tags", case: "stats").expect(matches: request)
    }

    @Test func `aggregates builds the corpus aggregates request`() throws {
        let request = try Mailgun.HTTP.Reporting.Tags.aggregates(
            try Domain("parity.example.com"),
            tag: "newsletter",
            .init(type: "providers")
        )
        Corpus.load("Reporting.Tags", case: "aggregates").expect(matches: request)
    }

    @Test func `limits builds the corpus limits request`() throws {
        let request = try Mailgun.HTTP.Reporting.Tags.limits(try Domain("parity.example.com"))
        Corpus.load("Reporting.Tags", case: "limits").expect(matches: request)
    }
}
