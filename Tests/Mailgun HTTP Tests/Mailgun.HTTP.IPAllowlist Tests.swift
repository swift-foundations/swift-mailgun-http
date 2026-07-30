import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.IPAllowlist {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.IPAllowlist.Construction.Unit {
    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.IPAllowlist.list()
        Corpus.load("IPAllowlist", case: "list").expect(matches: request)
    }

    @Test func `update builds the corpus update request`() throws {
        let request = try Mailgun.HTTP.IPAllowlist.update(
            .init(address: "203.0.113.10/32", description: "Parity updated allowlist entry")
        )
        Corpus.load("IPAllowlist", case: "update").expect(matches: request)
    }

    @Test func `add builds the corpus add request`() throws {
        let request = try Mailgun.HTTP.IPAllowlist.add(
            .init(address: "203.0.113.10/32", description: "Parity allowlist entry")
        )
        Corpus.load("IPAllowlist", case: "add").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.IPAllowlist.delete(.init(address: "203.0.113.10/32"))
        Corpus.load("IPAllowlist", case: "delete").expect(matches: request)
    }
}
