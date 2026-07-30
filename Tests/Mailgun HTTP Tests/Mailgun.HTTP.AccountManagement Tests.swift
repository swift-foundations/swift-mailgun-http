import EmailAddress_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.AccountManagement {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.AccountManagement.Construction.Unit {
    @Test func `updateAccount builds the corpus updateAccount request`() throws {
        let request = try Mailgun.HTTP.AccountManagement.updateAccount(
            Mailgun.AccountManagement.Update.Request(
                name: "Parity Account",
                inactiveSessionTimeout: 900,
                absoluteSessionTimeout: 86400,
                logoutRedirectUrl: "https://parity.example.com/logout"
            )
        )
        Corpus.load("AccountManagement", case: "updateAccount").expect(matches: request)
    }

    @Test func `getHttpSigningKey builds the corpus getHttpSigningKey request`() throws {
        let request = try Mailgun.HTTP.AccountManagement.getHttpSigningKey()
        Corpus.load("AccountManagement", case: "getHttpSigningKey").expect(matches: request)
    }

    @Test func `regenerateHttpSigningKey builds the corpus regenerateHttpSigningKey request`()
        throws
    {
        let request = try Mailgun.HTTP.AccountManagement.regenerateHttpSigningKey()
        Corpus.load("AccountManagement", case: "regenerateHttpSigningKey").expect(matches: request)
    }

    @Test func `getSandboxAuthRecipients builds the corpus getSandboxAuthRecipients request`()
        throws
    {
        let request = try Mailgun.HTTP.AccountManagement.getSandboxAuthRecipients()
        Corpus.load("AccountManagement", case: "getSandboxAuthRecipients").expect(matches: request)
    }

    @Test func `addSandboxAuthRecipient builds the corpus addSandboxAuthRecipient request`()
        throws
    {
        let request = try Mailgun.HTTP.AccountManagement.addSandboxAuthRecipient(
            .init(email: try EmailAddress("recipient@parity.example.com"))
        )
        Corpus.load("AccountManagement", case: "addSandboxAuthRecipient").expect(matches: request)
    }

    @Test func `deleteSandboxAuthRecipient builds the corpus deleteSandboxAuthRecipient request`()
        throws
    {
        let request = try Mailgun.HTTP.AccountManagement.deleteSandboxAuthRecipient(
            try EmailAddress("recipient@parity.example.com")
        )
        Corpus.load("AccountManagement", case: "deleteSandboxAuthRecipient")
            .expect(matches: request)
    }

    @Test func `resendActivationEmail builds the corpus resendActivationEmail request`() throws {
        let request = try Mailgun.HTTP.AccountManagement.resendActivationEmail()
        Corpus.load("AccountManagement", case: "resendActivationEmail").expect(matches: request)
    }

    @Test func `getSAMLOrganization builds the corpus getSAMLOrganization request`() throws {
        let request = try Mailgun.HTTP.AccountManagement.getSAMLOrganization()
        Corpus.load("AccountManagement", case: "getSAMLOrganization").expect(matches: request)
    }

    @Test func `addSAMLOrganization builds the corpus addSAMLOrganization request`() throws {
        let request = try Mailgun.HTTP.AccountManagement.addSAMLOrganization(
            .init(userId: "user-1234", domain: "parity.example.com")
        )
        Corpus.load("AccountManagement", case: "addSAMLOrganization").expect(matches: request)
    }
}
