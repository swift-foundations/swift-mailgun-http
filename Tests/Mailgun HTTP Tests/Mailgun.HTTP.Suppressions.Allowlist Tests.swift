import Domain_Standard
import EmailAddress_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Suppressions.Allowlist {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Suppressions.Allowlist.Construction.Unit {
    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Allowlist.get(
            try Domain("parity.example.com"),
            value: "user@parity.example.com"
        )
        Corpus.load("Suppressions.Allowlist", case: "get").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Allowlist.delete(
            try Domain("parity.example.com"),
            value: "user@parity.example.com"
        )
        Corpus.load("Suppressions.Allowlist", case: "delete").expect(matches: request)
    }

    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Allowlist.list(
            try Domain("parity.example.com"),
            .init(
                address: try EmailAddress("user@parity.example.com"),
                term: "parity-term",
                limit: 25,
                page: "next-page-token"
            )
        )
        Corpus.load("Suppressions.Allowlist", case: "list").expect(matches: request)
    }

    @Test func `list with no request builds the corpus list-empty request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Allowlist.list(try Domain("parity.example.com"))
        Corpus.load("Suppressions.Allowlist", case: "list-empty").expect(matches: request)
    }

    @Test func `create with an address builds the corpus create-address request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Allowlist.create(
            try Domain("parity.example.com"),
            .address(try EmailAddress("user@parity.example.com"))
        )
        Corpus.load("Suppressions.Allowlist", case: "create-address").expect(matches: request)
    }

    @Test func `create with a domain builds the corpus create-domain request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Allowlist.create(
            try Domain("parity.example.com"),
            .domain(try Domain("allowed.parity.example.com"))
        )
        Corpus.load("Suppressions.Allowlist", case: "create-domain").expect(matches: request)
    }

    @Test func `deleteAll builds the corpus deleteAll request`() throws {
        let request = try Mailgun.HTTP.Suppressions.Allowlist.deleteAll(
            try Domain("parity.example.com")
        )
        Corpus.load("Suppressions.Allowlist", case: "deleteAll").expect(matches: request)
    }
}
