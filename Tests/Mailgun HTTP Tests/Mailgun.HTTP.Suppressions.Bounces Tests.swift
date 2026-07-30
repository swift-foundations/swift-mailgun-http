import Domain_Standard
import EmailAddress_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Suppressions.Bounces {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Suppressions.Bounces.Construction.Unit {
    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Bounces.get(
            try Domain("parity.example.com"),
            address: try EmailAddress("user@parity.example.com")
        )
        Corpus.load("Suppressions.Bounces", case: "get").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Bounces.delete(
            try Domain("parity.example.com"),
            address: try EmailAddress("user@parity.example.com")
        )
        Corpus.load("Suppressions.Bounces", case: "delete").expect(matches: request)
    }

    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Bounces.list(
            try Domain("parity.example.com"),
            .init(limit: 25, page: "next-page-token", term: "parity-term")
        )
        Corpus.load("Suppressions.Bounces", case: "list").expect(matches: request)
    }

    @Test func `list with no request builds the corpus list-empty request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Bounces.list(try Domain("parity.example.com"))
        Corpus.load("Suppressions.Bounces", case: "list-empty").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Bounces.create(
            try Domain("parity.example.com"),
            .init(
                address: try EmailAddress("user@parity.example.com"),
                code: "550",
                error: "Mailbox does not exist",
                createdAt: "Thu, 01 Jan 2026 00:00:00 UTC"
            )
        )
        Corpus.load("Suppressions.Bounces", case: "create").expect(matches: request)
    }

    @Test func `deleteAll builds the corpus deleteAll request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Bounces.deleteAll(
            try Domain("parity.example.com")
        )
        Corpus.load("Suppressions.Bounces", case: "deleteAll").expect(matches: request)
    }
}
