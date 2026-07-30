import EmailAddress_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Lists {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Lists.Construction.Unit {
    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Lists.create(
            .init(
                address: try EmailAddress("developers@parity.example.com"),
                name: "Developers",
                description: "Parity corpus list",
                accessLevel: .members,
                replyPreference: .list
            )
        )
        Corpus.load("Lists", case: "create").expect(matches: request)
    }

    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.Lists.list(
            .init(limit: 25, skip: 5, address: try EmailAddress("developers@parity.example.com"))
        )
        Corpus.load("Lists", case: "list").expect(matches: request)
    }

    @Test func `list with no parameters builds the corpus list-empty request`() throws {
        let request = try Mailgun.HTTP.Lists.list()
        Corpus.load("Lists", case: "list-empty").expect(matches: request)
    }

    @Test func `members builds the corpus members request`() throws {
        let request = try Mailgun.HTTP.Lists.members(
            try EmailAddress("developers@parity.example.com"),
            .init(
                address: try EmailAddress("member@parity.example.com"),
                subscribed: true,
                limit: 10,
                skip: 2
            )
        )
        Corpus.load("Lists", case: "members").expect(matches: request)
    }

    @Test func `addMember builds the corpus addMember request`() throws {
        let request = try Mailgun.HTTP.Lists.addMember(
            try EmailAddress("developers@parity.example.com"),
            .init(
                address: try EmailAddress("new@parity.example.com"),
                name: "New Member",
                vars: ["role": "developer"],
                subscribed: true,
                upsert: false
            )
        )
        Corpus.load("Lists", case: "addMember").expect(matches: request)
    }

    @Test func `bulkAdd builds the corpus bulkAdd request`() throws {
        let request = try Mailgun.HTTP.Lists.bulkAdd(
            try EmailAddress("developers@parity.example.com"),
            [
                .init(
                    address: try EmailAddress("bulk1@parity.example.com"),
                    name: "Bulk One",
                    vars: ["seat": "1"],
                    subscribed: true
                ),
                .init(
                    address: try EmailAddress("bulk2@parity.example.com"),
                    name: "Bulk Two",
                    subscribed: false
                ),
            ],
            upsert: true
        )
        Corpus.load("Lists", case: "bulkAdd").expect(matches: request)
    }

    @Test func `getMember builds the corpus getMember request`() throws {
        let request = try Mailgun.HTTP.Lists.getMember(
            try EmailAddress("developers@parity.example.com"),
            try EmailAddress("member@parity.example.com")
        )
        Corpus.load("Lists", case: "getMember").expect(matches: request)
    }

    @Test func `updateMember builds the corpus updateMember request`() throws {
        let request = try Mailgun.HTTP.Lists.updateMember(
            try EmailAddress("developers@parity.example.com"),
            try EmailAddress("member@parity.example.com"),
            .init(
                address: try EmailAddress("renamed@parity.example.com"),
                name: "Renamed Member",
                vars: ["role": "maintainer"],
                subscribed: false
            )
        )
        Corpus.load("Lists", case: "updateMember").expect(matches: request)
    }

    @Test func `deleteMember builds the corpus deleteMember request`() throws {
        let request = try Mailgun.HTTP.Lists.deleteMember(
            try EmailAddress("developers@parity.example.com"),
            try EmailAddress("member@parity.example.com")
        )
        Corpus.load("Lists", case: "deleteMember").expect(matches: request)
    }

    @Test func `update builds the corpus update request`() throws {
        let request = try Mailgun.HTTP.Lists.update(
            try EmailAddress("developers@parity.example.com"),
            .init(
                address: try EmailAddress("renamed-list@parity.example.com"),
                description: "Updated parity list",
                name: "Renamed List",
                accessLevel: .readonly,
                replyPreference: .sender,
                listId: "parity-list-id"
            )
        )
        Corpus.load("Lists", case: "update").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Lists.delete(
            try EmailAddress("developers@parity.example.com")
        )
        Corpus.load("Lists", case: "delete").expect(matches: request)
    }

    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.Lists.get(try EmailAddress("developers@parity.example.com"))
        Corpus.load("Lists", case: "get").expect(matches: request)
    }

    @Test func `pages builds the corpus pages request`() throws {
        let request = try Mailgun.HTTP.Lists.pages(limit: 50)
        Corpus.load("Lists", case: "pages").expect(matches: request)
    }

    @Test func `pages with no limit builds the corpus pages-empty request`() throws {
        let request = try Mailgun.HTTP.Lists.pages()
        Corpus.load("Lists", case: "pages-empty").expect(matches: request)
    }

    @Test func `memberPages builds the corpus memberPages request`() throws {
        let request = try Mailgun.HTTP.Lists.memberPages(
            try EmailAddress("developers@parity.example.com"),
            .init(
                subscribed: true,
                limit: 20,
                address: try EmailAddress("member@parity.example.com"),
                page: .next
            )
        )
        Corpus.load("Lists", case: "memberPages").expect(matches: request)
    }
}
