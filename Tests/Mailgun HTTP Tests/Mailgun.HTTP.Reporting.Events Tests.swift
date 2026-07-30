import Domain_Standard
import EmailAddress_Standard
import Testing
import Time_Primitive

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Reporting.Events {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Reporting.Events.Construction.Unit {
    @Test func `list builds the corpus list.full request`() throws {
        let request = try Mailgun.HTTP.Reporting.Events.list(
            try Domain("parity.example.com"),
            .init(
                begin: .init(referenceDate: Time(secondsSinceEpoch: 1_700_000_000)),
                end: .init(referenceDate: Time(secondsSinceEpoch: 1_700_086_400)),
                ascending: .yes,
                limit: 100,
                event: .delivered,
                list: "subscribers@parity.example.com",
                attachment: "report.pdf",
                from: try EmailAddress("sender@parity.example.com"),
                messageId: "20231113000000.1.PARITYFIXTURE@parity.example.com",
                subject: "Parity fixture subject",
                to: try EmailAddress("to@parity.example.com"),
                size: 2048,
                recipient: try EmailAddress("recipient@parity.example.com"),
                recipients: [
                    try EmailAddress("first@parity.example.com"),
                    try EmailAddress("second@parity.example.com"),
                ],
                tags: ["newsletter", "onboarding"],
                severity: .permanent
            )
        )
        Corpus.load("Reporting.Events", case: "list.full").expect(matches: request)
    }

    @Test func `list with no query builds the corpus list.bare request`() throws {
        let request = try Mailgun.HTTP.Reporting.Events.list(try Domain("parity.example.com"))
        Corpus.load("Reporting.Events", case: "list.bare").expect(matches: request)
    }
}
