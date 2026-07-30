import Domain_Standard
import EmailAddress_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Suppressions.Unsubscribe {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Suppressions.Unsubscribe.Construction.Unit {
    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Unsubscribe.get(
            try Domain("parity.example.com"),
            address: try EmailAddress("user@parity.example.com")
        )
        Corpus.load("Suppressions.Unsubscribe", case: "get").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Unsubscribe.delete(
            try Domain("parity.example.com"),
            address: try EmailAddress("user@parity.example.com")
        )
        Corpus.load("Suppressions.Unsubscribe", case: "delete").expect(matches: request)
    }

    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Unsubscribe.list(
            try Domain("parity.example.com"),
            .init(
                address: try EmailAddress("user@parity.example.com"),
                term: "parity-term",
                limit: 25,
                page: "next-page-token"
            )
        )
        Corpus.load("Suppressions.Unsubscribe", case: "list").expect(matches: request)
    }

    @Test func `list with no request builds the corpus list-empty request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Unsubscribe.list(
            try Domain("parity.example.com")
        )
        Corpus.load("Suppressions.Unsubscribe", case: "list-empty").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Unsubscribe.create(
            try Domain("parity.example.com"),
            .init(
                address: try EmailAddress("user@parity.example.com"),
                tags: ["newsletter", "promotions"],
                createdAt: "Thu, 01 Jan 2026 00:00:00 UTC"
            )
        )
        Corpus.load("Suppressions.Unsubscribe", case: "create").expect(matches: request)
    }

    @Test func `deleteAll builds the corpus deleteAll request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Unsubscribe.deleteAll(
            try Domain("parity.example.com")
        )
        Corpus.load("Suppressions.Unsubscribe", case: "deleteAll").expect(matches: request)
    }
}
