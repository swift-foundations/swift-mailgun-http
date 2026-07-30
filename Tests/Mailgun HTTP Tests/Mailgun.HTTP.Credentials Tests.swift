import Domain_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Credentials {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Credentials.Construction.Unit {
    @Test func `list with no request builds the corpus list-nil request`() throws {
        let request = try Mailgun.HTTP.Credentials.list(domain: try Domain("parity.example.com"))
        Corpus.load("Credentials", case: "list-nil").expect(matches: request)
    }

    @Test func `list builds the corpus list-full request`() throws {
        let request = try Mailgun.HTTP.Credentials.list(
            domain: try Domain("parity.example.com"),
            .init(skip: 10, limit: 25)
        )
        Corpus.load("Credentials", case: "list-full").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Credentials.create(
            .init(
                login: "alice@parity.example.com",
                mailbox: "alice",
                password: "fixed-parity-password",
                system: false
            ),
            domain: try Domain("parity.example.com")
        )
        Corpus.load("Credentials", case: "create").expect(matches: request)
    }

    @Test func `deleteAll builds the corpus deleteAll request`() throws {
        let request = try Mailgun.HTTP.Credentials.deleteAll(
            domain: try Domain("parity.example.com")
        )
        Corpus.load("Credentials", case: "deleteAll").expect(matches: request)
    }

    @Test func `update builds the corpus update request`() throws {
        let request = try Mailgun.HTTP.Credentials.update(
            "alice@parity.example.com",
            .init(password: "new-fixed-password"),
            domain: try Domain("parity.example.com")
        )
        Corpus.load("Credentials", case: "update").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Credentials.delete(
            "alice@parity.example.com",
            domain: try Domain("parity.example.com")
        )
        Corpus.load("Credentials", case: "delete").expect(matches: request)
    }

    @Test func `updateMailbox builds the corpus updateMailbox request`() throws {
        let request = try Mailgun.HTTP.Credentials.updateMailbox(
            "alice@parity.example.com",
            .init(password: "mailbox-fixed-password"),
            domain: try Domain("parity.example.com")
        )
        Corpus.load("Credentials", case: "updateMailbox").expect(matches: request)
    }
}
