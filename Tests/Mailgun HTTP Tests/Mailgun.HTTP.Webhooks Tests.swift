import Domain_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Webhooks {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Webhooks.Construction.Unit {
    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.Webhooks.list(try Domain("parity.example.com"))
        Corpus.load("Webhooks", case: "list").expect(matches: request)
    }

    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Webhooks.get(.delivered, domain: try Domain("parity.example.com"))
        Corpus.load("Webhooks", case: "get").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Webhooks.create(
            .init(
                id: .opened,
                url: [
                    "https://parity.example.com/hooks/opened",
                    "https://parity.example.com/hooks/opened-2",
                ]
            ),
            domain: try Domain("parity.example.com")
        )
        Corpus.load("Webhooks", case: "create").expect(matches: request)
    }

    @Test func `update builds the corpus update request`() throws {
        let request = try Mailgun.HTTP.Webhooks.update(
            .clicked,
            .init(url: "https://parity.example.com/hooks/clicked"),
            domain: try Domain("parity.example.com")
        )
        Corpus.load("Webhooks", case: "update").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Webhooks.delete(
            .permanentFail,
            domain: try Domain("parity.example.com")
        )
        Corpus.load("Webhooks", case: "delete").expect(matches: request)
    }
}
