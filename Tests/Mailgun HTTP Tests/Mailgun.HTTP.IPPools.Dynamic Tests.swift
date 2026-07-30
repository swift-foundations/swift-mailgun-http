import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.IPPools.Dynamic {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.IPPools.Dynamic.Construction.Unit {
    @Test func `listHistory builds the corpus listHistory.full request`() throws {
        let request = try Mailgun.HTTP.IPPools.Dynamic.listHistory(
            .init(
                limit: 25,
                includeSubaccounts: true,
                domain: "parity.example.com",
                before: "cursor-before",
                after: "cursor-after",
                movedTo: "pool-b",
                movedFrom: "pool-a"
            )
        )
        Corpus.load("IPPools.Dynamic", case: "listHistory.full").expect(matches: request)
    }

    @Test func `listHistory with no parameters builds the corpus listHistory.empty request`()
        throws
    {
        let request = try Mailgun.HTTP.IPPools.Dynamic.listHistory()
        Corpus.load("IPPools.Dynamic", case: "listHistory.empty").expect(matches: request)
    }

    @Test func `removeOverride builds the corpus removeOverride request`() throws {
        let request = try Mailgun.HTTP.IPPools.Dynamic.removeOverride(domain: "parity.example.com")
        Corpus.load("IPPools.Dynamic", case: "removeOverride").expect(matches: request)
    }
}
