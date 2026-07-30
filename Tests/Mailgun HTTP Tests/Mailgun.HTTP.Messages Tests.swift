import Domain_Standard
import EmailAddress_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.Messages {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.Messages.Construction.Unit {
    @Test func `send builds the corpus send request`() throws {
        let request = try Mailgun.HTTP.Messages.send(
            try Domain("parity.example.com"),
            .init(
                from: try EmailAddress("sender@parity.example.com"),
                to: [
                    try EmailAddress("first@parity.example.com"),
                    try EmailAddress("second@parity.example.com"),
                ],
                subject: "Parity corpus subject",
                html: "<h1>Parity</h1><p>Hello</p>",
                text: "Parity plain text",
                cc: [try EmailAddress("cc@parity.example.com")],
                bcc: [try EmailAddress("bcc@parity.example.com")],
                ampHtml: "<html amp4email>Parity AMP</html>",
                template: "parity-template",
                templateVersion: "v2",
                templateText: true,
                templateVariables: #"{"key":"value"}"#,
                attachments: [
                    .init(
                        data: Array("attachment-bytes".utf8),
                        filename: "report.txt",
                        contentType: "text/plain"
                    )
                ],
                inline: [
                    .init(
                        data: Array("inline-bytes".utf8),
                        filename: "logo.png",
                        contentType: "image/png"
                    )
                ],
                tags: ["parity", "corpus"],
                dkim: true,
                secondaryDkim: "secondary.parity.example.com",
                secondaryDkimPublic: "public.parity.example.com",
                deliveryTimeOptimizePeriod: "24h",
                timeZoneLocalize: "17:00",
                testMode: true,
                tracking: .yes,
                trackingClicks: .htmlOnly,
                trackingOpens: true,
                requireTls: true,
                skipVerification: false,
                sendingIp: "203.0.113.10",
                sendingIpPool: "pool-1",
                trackingPixelLocationTop: true,
                headers: ["X-Parity": "yes"],
                variables: ["campaign": "parity"],
                recipientVariables: #"{"first@parity.example.com":{"id":1}}"#
            )
        )
        Corpus.load("Messages", case: "send").expect(matchesNormalizingBoundary: request)
    }

    @Test func `sendMime builds the corpus sendMime request`() throws {
        let request = try Mailgun.HTTP.Messages.sendMime(
            try Domain("parity.example.com"),
            .init(
                to: [
                    try EmailAddress("first@parity.example.com"),
                    try EmailAddress("second@parity.example.com"),
                ],
                message: Array(
                    "From: sender@parity.example.com\r\nSubject: Parity MIME\r\n\r\nBody".utf8
                ),
                template: "parity-template",
                templateVersion: "v2",
                templateText: false,
                templateVariables: #"{"key":"value"}"#,
                tags: ["parity", "mime"],
                dkim: false,
                secondaryDkim: "secondary.parity.example.com",
                secondaryDkimPublic: "public.parity.example.com",
                deliveryTimeOptimizePeriod: "48h",
                timeZoneLocalize: "09:30",
                testMode: true,
                tracking: .no,
                trackingClicks: .yes,
                trackingOpens: false,
                requireTls: false,
                skipVerification: true,
                sendingIp: "203.0.113.11",
                sendingIpPool: "pool-2",
                trackingPixelLocationTop: false,
                headers: ["X-Parity-Mime": "yes"],
                variables: ["campaign": "parity-mime"],
                recipientVariables: #"{"second@parity.example.com":{"id":2}}"#
            )
        )
        Corpus.load("Messages", case: "sendMime").expect(matchesNormalizingBoundary: request)
    }

    @Test func `retrieve builds the corpus retrieve request`() throws {
        let request = try Mailgun.HTTP.Messages.retrieve(
            try Domain("parity.example.com"),
            storageKey: "storage-key-123"
        )
        Corpus.load("Messages", case: "retrieve").expect(matches: request)
    }

    @Test func `queueStatus builds the corpus queueStatus request`() throws {
        let request = try Mailgun.HTTP.Messages.queueStatus(try Domain("parity.example.com"))
        Corpus.load("Messages", case: "queueStatus").expect(matches: request)
    }

    @Test func `deleteScheduled builds the corpus deleteScheduled request`() throws {
        let request = try Mailgun.HTTP.Messages.deleteScheduled(try Domain("parity.example.com"))
        Corpus.load("Messages", case: "deleteScheduled").expect(matches: request)
    }
}
