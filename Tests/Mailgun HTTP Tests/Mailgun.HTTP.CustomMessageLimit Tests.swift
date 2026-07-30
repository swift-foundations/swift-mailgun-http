import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.CustomMessageLimit {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.CustomMessageLimit.Construction.Unit {
    @Test func `getMonthlyLimit builds the corpus getMonthly request`() throws {
        let request = try Mailgun.HTTP.CustomMessageLimit.getMonthlyLimit()
        Corpus.load("CustomMessageLimit", case: "getMonthly").expect(matches: request)
    }

    @Test func `setMonthlyLimit builds the corpus setMonthly request`() throws {
        let request = try Mailgun.HTTP.CustomMessageLimit.setMonthlyLimit(.init(limit: 50000))
        Corpus.load("CustomMessageLimit", case: "setMonthly").expect(matches: request)
    }

    @Test func `deleteMonthlyLimit builds the corpus deleteMonthly request`() throws {
        let request = try Mailgun.HTTP.CustomMessageLimit.deleteMonthlyLimit()
        Corpus.load("CustomMessageLimit", case: "deleteMonthly").expect(matches: request)
    }

    @Test func `enableAccount builds the corpus enableAccount request`() throws {
        let request = try Mailgun.HTTP.CustomMessageLimit.enableAccount()
        Corpus.load("CustomMessageLimit", case: "enableAccount").expect(matches: request)
    }
}
