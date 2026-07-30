import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Routes {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Routes.Construction.Unit {
    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Routes.create(
            Mailgun.Routes.Create.Request(
                priority: 1,
                description: "Parity corpus route",
                expression: #"match_recipient(".*@parity.example.com")"#,
                action: [
                    #"forward("https://parity.example.com/inbound")"#,
                    "stop()",
                ]
            )
        )
        Corpus.load("Routes", case: "create").expect(matches: request)
    }

    @Test func `list builds the corpus list request with limit and skip`() throws {
        let request = try Mailgun.HTTP.Routes.list(limit: 25, skip: 5)
        Corpus.load("Routes", case: "list").expect(matches: request)
    }

    @Test func `list with no parameters builds the corpus list-empty request`() throws {
        let request = try Mailgun.HTTP.Routes.list()
        Corpus.load("Routes", case: "list-empty").expect(matches: request)
    }

    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Routes.get("route-id-123")
        Corpus.load("Routes", case: "get").expect(matches: request)
    }

    @Test func `update builds the corpus update request`() throws {
        let request = try Mailgun.HTTP.Routes.update(
            "route-id-123",
            Mailgun.Routes.Update.Request(
                id: "route-id-123",
                priority: 2,
                description: "Updated parity route",
                expression: #"match_header("subject", ".*parity.*")"#,
                action: ["store()", "stop()"]
            )
        )
        Corpus.load("Routes", case: "update").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Routes.delete("route-id-123")
        Corpus.load("Routes", case: "delete").expect(matches: request)
    }

    @Test func `match builds the corpus match request`() throws {
        let request = try Mailgun.HTTP.Routes.match("someone@parity.example.com")
        Corpus.load("Routes", case: "match").expect(matches: request)
    }
}
