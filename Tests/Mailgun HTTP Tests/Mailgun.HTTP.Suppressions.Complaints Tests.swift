import Domain_Standard
import EmailAddress_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Suppressions.Complaints {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Suppressions.Complaints.Construction.Unit {
    @Test func `importList builds the corpus importList request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Complaints.importList(
            try Domain("parity.example.com"),
            .init(file: Array("address\ncomplained@parity.example.com\n".utf8))
        )
        Corpus.load("Suppressions.Complaints", case: "importList").expect(matches: request)
    }

    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Complaints.get(
            try Domain("parity.example.com"),
            address: try EmailAddress("user@parity.example.com")
        )
        Corpus.load("Suppressions.Complaints", case: "get").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Complaints.delete(
            try Domain("parity.example.com"),
            address: try EmailAddress("user@parity.example.com")
        )
        Corpus.load("Suppressions.Complaints", case: "delete").expect(matches: request)
    }

    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Complaints.list(
            try Domain("parity.example.com"),
            .init(
                address: try EmailAddress("user@parity.example.com"),
                term: "parity-term",
                limit: 25,
                page: "next-page-token"
            )
        )
        Corpus.load("Suppressions.Complaints", case: "list").expect(matches: request)
    }

    @Test func `list with no request builds the corpus list-empty request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Complaints.list(
            try Domain("parity.example.com")
        )
        Corpus.load("Suppressions.Complaints", case: "list-empty").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Complaints.create(
            try Domain("parity.example.com"),
            .init(
                address: try EmailAddress("user@parity.example.com"),
                createdAt: "Thu, 01 Jan 2026 00:00:00 UTC"
            )
        )
        Corpus.load("Suppressions.Complaints", case: "create").expect(matches: request)
    }

    @Test func `deleteAll builds the corpus deleteAll request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Complaints.deleteAll(
            try Domain("parity.example.com")
        )
        Corpus.load("Suppressions.Complaints", case: "deleteAll").expect(matches: request)
    }
}
