import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.IPs.Warmup {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.IPs.Warmup.Construction.Unit {
    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.IPs.Warmup.list()
        Corpus.load("IPs.Warmup", case: "list").expect(matches: request)
    }

    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.IPs.Warmup.get("192.161.0.1")
        Corpus.load("IPs.Warmup", case: "get").expect(matches: request)
    }

    @Test func `create builds the corpus create.full request`() throws {
        let request = try Mailgun.HTTP.IPs.Warmup.create(
            "192.161.0.1",
            .init(enabled: true, volumeDailyCapacity: 1000)
        )
        Corpus.load("IPs.Warmup", case: "create.full").expect(matches: request)
    }

    @Test func `create with no fields builds the corpus create.empty request`() throws {
        let request = try Mailgun.HTTP.IPs.Warmup.create("192.161.0.1", .init())
        Corpus.load("IPs.Warmup", case: "create.empty").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.IPs.Warmup.delete("192.161.0.1")
        Corpus.load("IPs.Warmup", case: "delete").expect(matches: request)
    }
}
