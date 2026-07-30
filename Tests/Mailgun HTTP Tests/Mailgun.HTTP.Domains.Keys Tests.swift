import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Domains.Keys {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Domains.Keys.Construction.Unit {
    @Test func `list with no request builds the corpus list-nil request`() throws {
        let request = try Mailgun.HTTP.Domains.Keys.list()
        Corpus.load("Domains.Keys", case: "list-nil").expect(matches: request)
    }

    @Test func `list builds the corpus list-full request`() throws {
        let request = try Mailgun.HTTP.Domains.Keys.list(
            .init(
                page: "next-page-token",
                limit: 10,
                signingDomain: "parity.example.com",
                selector: "parity-selector"
            )
        )
        Corpus.load("Domains.Keys", case: "list-full").expect(matches: request)
    }

    @Test func `create builds the corpus create request`() throws {
        let request = try Mailgun.HTTP.Domains.Keys.create(
            .init(
                signingDomain: "parity.example.com",
                selector: "parity-selector",
                bits: 2048,
                pem: "-----BEGIN PRIVATE KEY-----PARITYFIXTURE-----END PRIVATE KEY-----"
            )
        )
        Corpus.load("Domains.Keys", case: "create").expect(matches: request)
    }

    @Test func `delete builds the corpus delete request`() throws {
        let request = try Mailgun.HTTP.Domains.Keys.delete(
            .init(signingDomain: "parity.example.com", selector: "parity-selector")
        )
        Corpus.load("Domains.Keys", case: "delete").expect(matches: request)
    }

    @Test func `activate builds the corpus activate request`() throws {
        let request = try Mailgun.HTTP.Domains.Keys.activate(
            authorityName: "parity.example.com",
            selector: "parity-selector"
        )
        Corpus.load("Domains.Keys", case: "activate").expect(matches: request)
    }

    @Test func `listDomainKeys builds the corpus listDomainKeys request`() throws {
        let request = try Mailgun.HTTP.Domains.Keys.listDomainKeys(
            authorityName: "parity.example.com"
        )
        Corpus.load("Domains.Keys", case: "listDomainKeys").expect(matches: request)
    }

    @Test func `deactivate builds the corpus deactivate request`() throws {
        let request = try Mailgun.HTTP.Domains.Keys.deactivate(
            authorityName: "parity.example.com",
            selector: "parity-selector"
        )
        Corpus.load("Domains.Keys", case: "deactivate").expect(matches: request)
    }

    @Test func `setDkimAuthority builds the corpus setDkimAuthority request`() throws {
        let request = try Mailgun.HTTP.Domains.Keys.setDkimAuthority(
            domainName: "parity.example.com",
            .init(dkimAuthority: "authority.example.com")
        )
        Corpus.load("Domains.Keys", case: "setDkimAuthority").expect(matches: request)
    }

    @Test func `setDkimSelector builds the corpus setDkimSelector request`() throws {
        let request = try Mailgun.HTTP.Domains.Keys.setDkimSelector(
            domainName: "parity.example.com",
            .init(dkimSelector: "parity-selector")
        )
        Corpus.load("Domains.Keys", case: "setDkimSelector").expect(matches: request)
    }
}
