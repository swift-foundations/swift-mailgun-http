import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.IPPools {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.IPPools.Construction.Unit {
    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.IPPools.list()
        Corpus.load("IPPools", case: "list").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.IPPools.create(
            .init(
                name: "parity-pool",
                description: "Parity fixture pool",
                ips: ["192.161.0.1", "192.161.0.2"]
            )
        )
        Corpus.load("IPPools", case: "create").expect(matches: request)
    }

    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.IPPools.get("parity-pool-id")
        Corpus.load("IPPools", case: "get").expect(matches: request)
    }

    @Test func `update builds the corpus update request`() throws {
        let request = try Mailgun.HTTP.IPPools.update(
            "parity-pool-id",
            .init(
                name: "parity-pool-renamed",
                description: "Updated parity fixture pool",
                addIps: ["192.161.0.3"],
                removeIps: ["192.161.0.1"]
            )
        )
        Corpus.load("IPPools", case: "update").expect(matches: request)
    }

    @Test func `delete with a replacement pool builds the corpus delete.query request`() throws {
        let request = try Mailgun.HTTP.IPPools.delete(
            "parity-pool-id",
            .init(ip: "192.161.0.1", poolId: "replacement-pool-id")
        )
        Corpus.load("IPPools", case: "delete.query").expect(matches: request)
    }

    @Test func `delete with no request builds the corpus delete.bare request`() throws {
        let request = try Mailgun.HTTP.IPPools.delete("parity-pool-id")
        Corpus.load("IPPools", case: "delete.bare").expect(matches: request)
    }

    @Test func `listDomains builds the corpus listDomains request`() throws {
        let request = try Mailgun.HTTP.IPPools.listDomains("parity-pool-id")
        Corpus.load("IPPools", case: "listDomains").expect(matches: request)
    }
}
