import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Users {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Users.Construction.Unit {
    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.Users.list(.init(role: .admin, limit: 25, skip: 5))
        Corpus.load("Users", case: "list").expect(matches: request)
    }

    @Test func `list with no request builds the corpus list-nil request`() throws {
        let request = try Mailgun.HTTP.Users.list()
        Corpus.load("Users", case: "list-nil").expect(matches: request)
    }

    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Users.get("parity-user-id")
        Corpus.load("Users", case: "get").expect(matches: request)
    }

    @Test func `me builds the corpus me request`() throws {
        let request = try Mailgun.HTTP.Users.me()
        Corpus.load("Users", case: "me").expect(matches: request)
    }

    @Test func `addToOrganization builds the corpus addToOrganization request`() throws {
        let request = try Mailgun.HTTP.Users.addToOrganization(
            userId: "parity-user-id",
            orgId: "parity-org-id"
        )
        Corpus.load("Users", case: "addToOrganization").expect(matches: request)
    }

    @Test func `removeFromOrganization builds the corpus removeFromOrganization request`() throws {
        let request = try Mailgun.HTTP.Users.removeFromOrganization(
            userId: "parity-user-id",
            orgId: "parity-org-id"
        )
        Corpus.load("Users", case: "removeFromOrganization").expect(matches: request)
    }
}
