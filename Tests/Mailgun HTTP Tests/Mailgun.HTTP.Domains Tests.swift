import Domain_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Domains {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Domains.Construction.Unit {
    @Test func `list with no request builds the corpus list-nil request`() throws {
        let request = try Mailgun.HTTP.Domains.list()
        Corpus.load("Domains", case: "list-nil").expect(matches: request)
    }

    @Test func `list builds the corpus list-full request`() throws {
        let request = try Mailgun.HTTP.Domains.list(
            .init(authority: "authority.example.com", state: .active, limit: 25, skip: 5)
        )
        Corpus.load("Domains", case: "list-full").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Domains.create(
            .init(
                name: "parity.example.com",
                smtpPassword: "parity-smtp-password",
                spamAction: .tag,
                wildcard: true,
                forceDkimAuthority: false,
                dkimKeySize: 2048,
                ips: "203.0.113.1,203.0.113.2",
                poolId: "pool-parity-1",
                webScheme: "https"
            )
        )
        Corpus.load("Domains", case: "create").expect(matches: request)
    }

    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Domains.get(try Domain("parity.example.com"))
        Corpus.load("Domains", case: "get").expect(matches: request)
    }

    @Test func `update builds the corpus update request`() throws {
        let request = try Mailgun.HTTP.Domains.update(
            try Domain("parity.example.com"),
            .init(spamAction: .block, webScheme: "https", wildcard: false)
        )
        Corpus.load("Domains", case: "update").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Domains.delete(try Domain("parity.example.com"))
        Corpus.load("Domains", case: "delete").expect(matches: request)
    }

    @Test func `verify builds the corpus verify request`() throws {
        let request = try Mailgun.HTTP.Domains.verify(try Domain("parity.example.com"))
        Corpus.load("Domains", case: "verify").expect(matches: request)
    }
}
