import Domain_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Domains.DKIMSecurity {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Domains.DKIMSecurity.Construction.Unit {
    @Test func `updateRotation builds the corpus updateRotation request`() throws {
        let request = try Mailgun.HTTP.Domains.DKIMSecurity.updateRotation(
            try Domain("parity.example.com"),
            .init(rotationEnabled: true, rotationInterval: "5d")
        )
        Corpus.load("Domains.DKIMSecurity", case: "updateRotation").expect(matches: request)
    }

    @Test func `rotateManually builds the corpus rotateManually request`() throws {
        let request = try Mailgun.HTTP.Domains.DKIMSecurity.rotateManually(
            try Domain("parity.example.com")
        )
        Corpus.load("Domains.DKIMSecurity", case: "rotateManually").expect(matches: request)
    }
}
