import Domain_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Domains.Tracking {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Domains.Tracking.Construction.Unit {
    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Domains.Tracking.get(try Domain("parity.example.com"))
        Corpus.load("Domains.Tracking", case: "get").expect(matches: request)
    }

    @Test func `updateClick builds the corpus updateClick request`() throws {
        let request = try Mailgun.HTTP.Domains.Tracking.updateClick(
            try Domain("parity.example.com"),
            .init(active: true)
        )
        Corpus.load("Domains.Tracking", case: "updateClick").expect(matches: request)
    }

    @Test func `updateOpen builds the corpus updateOpen request`() throws {
        let request = try Mailgun.HTTP.Domains.Tracking.updateOpen(
            try Domain("parity.example.com"),
            .init(active: false)
        )
        Corpus.load("Domains.Tracking", case: "updateOpen").expect(matches: request)
    }

    @Test func `updateUnsubscribe builds the corpus updateUnsubscribe request`() throws {
        let request = try Mailgun.HTTP.Domains.Tracking.updateUnsubscribe(
            try Domain("parity.example.com"),
            .init(
                active: true,
                htmlFooter: "<p>Unsubscribe <a href=\"%unsubscribe_url%\">here</a></p>",
                textFooter: "Unsubscribe: %unsubscribe_url%"
            )
        )
        Corpus.load("Domains.Tracking", case: "updateUnsubscribe").expect(matches: request)
    }
}
