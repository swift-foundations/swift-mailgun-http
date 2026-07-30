import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Subaccounts {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Subaccounts.Construction.Unit {
    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.get("parity-subaccount-id")
        Corpus.load("Subaccounts", case: "get").expect(matches: request)
    }

    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.list(
            .init(sort: .asc, filter: "parity-filter", limit: 10, skip: 2, enabled: true, closed: false)
        )
        Corpus.load("Subaccounts", case: "list").expect(matches: request)
    }

    @Test func `list with no request builds the corpus list-nil request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.list()
        Corpus.load("Subaccounts", case: "list-nil").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.create(.init(name: "Parity Subaccount"))
        Corpus.load("Subaccounts", case: "create").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.delete("parity-subaccount-id")
        Corpus.load("Subaccounts", case: "delete").expect(matches: request)
    }

    @Test func `disable builds the corpus disable request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.disable(
            "parity-subaccount-id",
            .init(reason: "abuse", note: "parity fixture note")
        )
        Corpus.load("Subaccounts", case: "disable").expect(matches: request)
    }

    @Test func `disable with no request builds the corpus disable-nil request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.disable("parity-subaccount-id")
        Corpus.load("Subaccounts", case: "disable-nil").expect(matches: request)
    }

    @Test func `enable builds the corpus enable request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.enable("parity-subaccount-id")
        Corpus.load("Subaccounts", case: "enable").expect(matches: request)
    }

    @Test func `getCustomLimit builds the corpus getCustomLimit request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.getCustomLimit("parity-subaccount-id")
        Corpus.load("Subaccounts", case: "getCustomLimit").expect(matches: request)
    }

    @Test func `updateCustomLimit builds the corpus updateCustomLimit request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.updateCustomLimit(
            "parity-subaccount-id",
            limit: 50000.0
        )
        Corpus.load("Subaccounts", case: "updateCustomLimit").expect(matches: request)
    }

    @Test func `deleteCustomLimit builds the corpus deleteCustomLimit request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.deleteCustomLimit("parity-subaccount-id")
        Corpus.load("Subaccounts", case: "deleteCustomLimit").expect(matches: request)
    }

    @Test func `updateFeatures builds the corpus updateFeatures request`() throws {
        let request = try Mailgun.HTTP.Subaccounts.updateFeatures(
            "parity-subaccount-id",
            .init(
                emailPreview: .init(enabled: true),
                inboxPlacement: .init(enabled: false),
                sending: .init(enabled: true),
                validations: .init(enabled: false),
                validationsBulk: .init(enabled: true)
            )
        )
        Corpus.load("Subaccounts", case: "updateFeatures").expect(matches: request)
    }
}
