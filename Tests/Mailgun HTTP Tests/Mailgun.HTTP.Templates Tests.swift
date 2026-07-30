import Domain_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Templates {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Templates.Construction.Unit {
    @Test func `list with no request builds the corpus list-nil request`() throws {
        let request = try Mailgun.HTTP.Templates.list(try Domain("parity.example.com"))
        Corpus.load("Templates", case: "list-nil").expect(matches: request)
    }

    @Test func `list builds the corpus list-full request`() throws {
        let request = try Mailgun.HTTP.Templates.list(
            try Domain("parity.example.com"),
            .init(page: .next, limit: 25, p: "cursor-token")
        )
        Corpus.load("Templates", case: "list-full").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Templates.create(
            try Domain("parity.example.com"),
            .init(
                name: "welcome-template",
                description: "Welcome email template",
                createdBy: "parity@example.com",
                template: "<html>Hello {{name}}</html>",
                tag: "v1",
                comment: "initial version",
                headers: "{\"X-Test\": \"parity\"}"
            )
        )
        Corpus.load("Templates", case: "create").expect(matches: request)
    }

    @Test func `deleteAll builds the corpus deleteAll request`() throws {
        let request = try Mailgun.HTTP.Templates.deleteAll(try Domain("parity.example.com"))
        Corpus.load("Templates", case: "deleteAll").expect(matches: request)
    }

    @Test func `versions with no request builds the corpus versions-nil request`() throws {
        let request = try Mailgun.HTTP.Templates.versions(
            try Domain("parity.example.com"),
            "welcome-template"
        )
        Corpus.load("Templates", case: "versions-nil").expect(matches: request)
    }

    @Test func `versions builds the corpus versions-full request`() throws {
        let request = try Mailgun.HTTP.Templates.versions(
            try Domain("parity.example.com"),
            "welcome-template",
            .init(page: .first, limit: 10, p: "version-cursor")
        )
        Corpus.load("Templates", case: "versions-full").expect(matches: request)
    }

    @Test func `createVersion builds the corpus createVersion request`() throws {
        let request = try Mailgun.HTTP.Templates.createVersion(
            try Domain("parity.example.com"),
            "welcome-template",
            .init(
                template: "<html>Hello v2 {{name}}</html>",
                tag: "v2",
                comment: "second version",
                active: "yes",
                headers: "{\"X-Test\": \"parity\"}"
            )
        )
        Corpus.load("Templates", case: "createVersion").expect(matches: request)
    }

    @Test func `get with no request builds the corpus get-nil request`() throws {
        let request = try Mailgun.HTTP.Templates.get(
            try Domain("parity.example.com"),
            "welcome-template"
        )
        Corpus.load("Templates", case: "get-nil").expect(matches: request)
    }

    @Test func `get with active builds the corpus get-active request`() throws {
        let request = try Mailgun.HTTP.Templates.get(
            try Domain("parity.example.com"),
            "welcome-template",
            .init(active: "yes")
        )
        Corpus.load("Templates", case: "get-active").expect(matches: request)
    }

    @Test func `update builds the corpus update request`() throws {
        let request = try Mailgun.HTTP.Templates.update(
            try Domain("parity.example.com"),
            "welcome-template",
            .init(description: "Updated description")
        )
        Corpus.load("Templates", case: "update").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Templates.delete(
            try Domain("parity.example.com"),
            "welcome-template"
        )
        Corpus.load("Templates", case: "delete").expect(matches: request)
    }

    @Test func `getVersion builds the corpus getVersion request`() throws {
        let request = try Mailgun.HTTP.Templates.getVersion(
            try Domain("parity.example.com"),
            "welcome-template",
            "v2"
        )
        Corpus.load("Templates", case: "getVersion").expect(matches: request)
    }

    @Test func `updateVersion builds the corpus updateVersion request`() throws {
        let request = try Mailgun.HTTP.Templates.updateVersion(
            try Domain("parity.example.com"),
            "welcome-template",
            "v2",
            .init(
                template: "<html>Hello v2.1 {{name}}</html>",
                comment: "tweak copy",
                active: "yes",
                headers: "{\"X-Test\": \"parity\"}"
            )
        )
        Corpus.load("Templates", case: "updateVersion").expect(matches: request)
    }

    @Test func `deleteVersion builds the corpus deleteVersion request`() throws {
        let request = try Mailgun.HTTP.Templates.deleteVersion(
            try Domain("parity.example.com"),
            "welcome-template",
            "v2"
        )
        Corpus.load("Templates", case: "deleteVersion").expect(matches: request)
    }

    @Test func `copyVersion with no request builds the corpus copyVersion-nil request`() throws {
        let request = try Mailgun.HTTP.Templates.copyVersion(
            try Domain("parity.example.com"),
            "welcome-template",
            "v2",
            "v3"
        )
        Corpus.load("Templates", case: "copyVersion-nil").expect(matches: request)
    }

    @Test func `copyVersion with a comment builds the corpus copyVersion-comment request`() throws {
        let request = try Mailgun.HTTP.Templates.copyVersion(
            try Domain("parity.example.com"),
            "welcome-template",
            "v2",
            "v3",
            .init(comment: "copied from v2")
        )
        Corpus.load("Templates", case: "copyVersion-comment").expect(matches: request)
    }
}
