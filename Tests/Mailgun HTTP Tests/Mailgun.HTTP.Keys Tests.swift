import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Keys {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Keys.Construction.Unit {
    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.Keys.list()
        Corpus.load("Keys", case: "list").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Keys.create(
            .init(description: "Parity fixture key", role: "admin", kind: "user")
        )
        Corpus.load("Keys", case: "create").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Keys.delete("parity-key-id")
        Corpus.load("Keys", case: "delete").expect(matches: request)
    }

    @Test func `addPublicKey builds the corpus addPublicKey request`() throws {
        let request = try Mailgun.HTTP.Keys.addPublicKey(
            .init(publicKey: "pubkey-parity-fixture-0123456789")
        )
        Corpus.load("Keys", case: "addPublicKey").expect(matches: request)
    }
}
