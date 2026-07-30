import Domain_Standard
import EmailAddress_Standard
import Foundation
import HTTP_Standard
import RFC_2045
import RFC_2046
import RFC_2183
import Time_Primitive

/// Wire-level request construction for `Mailgun.Messages` (official
/// reference: `.../send/mailgun/messages`).
///
/// Ported from the archived `Mailgun Messages Types/Messages.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Messages.txt`. `send` and `sendMime`
/// hand-roll their `multipart/form-data` body directly from
/// `RFC_2046.BodyPart` values — mirroring the archived router's
/// `SendMultipartConversion`/`MimeMultipartConversion` field-by-field — rather
/// than going through `HTML.Form.Coder.Multipart`, for three reasons the
/// generic encoder can't express:
///
/// - **A random boundary per call.** Every other multipart operation in this
///   package uses a fixed literal boundary; `send`/`sendMime` draw a fresh
///   `Part-<UUID>` boundary every call, exactly like the archived router
///   (`Part-\(UUID().uuidString)`), and the corpus fixture's own
///   `boundary=Part-<NORMALIZED>` placeholder exists specifically to
///   accommodate that (see `Corpus.Case.expect(matchesNormalizingBoundary:)`).
/// - **No automatic `Content-Type` on text fields.** `HTML.Form.Coder.Multipart`
///   always labels every part `Content-Type: text/plain; charset=UTF-8`; the
///   corpus shows plain fields (`from`, `to`, `o:tag`, ...) with no
///   `Content-Type` header at all — only the two file fields
///   (`attachment`/`inline`/`message`) carry one.
/// - **Prefixed keys from dictionaries** (`h:X-Parity`, `v:campaign`) and
///   **array fields that repeat a bare key** (`to`, `cc`, `o:tag`, ...) needed
///   field-by-field control matching the archived router's exact `CodingKeys`
///   ordering, which the corpus fixture is byte-for-byte sensitive to.
extension Mailgun.HTTP {
    public enum Messages: Sendable {}
}

extension Mailgun.HTTP.Messages {
    public static func send(
        _ domain: Domain,
        _ request: Mailgun.Messages.Send.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", domain.rawValue, "messages"]
        )
        try Self.attach(Self.parts(for: request), into: &httpRequest)
        return httpRequest
    }

    public static func sendMime(
        _ domain: Domain,
        _ request: Mailgun.Messages.Send.Mime.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(
            .post,
            ["v3", domain.rawValue, "messages.mime"]
        )
        try Self.attach(Self.parts(for: request), into: &httpRequest)
        return httpRequest
    }

    /// Addresses `/v3/domains/{domain}/messages/{storageKey}` — the
    /// `domains` literal segment `send`/`sendMime`/`deleteScheduled` omit.
    public static func retrieve(
        _ domain: Domain,
        storageKey: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", "domains", domain.rawValue, "messages", storageKey]
        )
    }

    public static func queueStatus(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(
            .get,
            ["v3", "domains", domain.rawValue, "sending_queues"]
        )
    }

    public static func deleteScheduled(
        _ domain: Domain
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v3", domain.rawValue, "envelopes"])
    }
}

// MARK: - Hand-rolled multipart assembly

extension Mailgun.HTTP.Messages {
    /// A `multipart/form-data` text field: `Content-Disposition` only, no
    /// `Content-Type` — matching the archived router's `addField`.
    fileprivate static func field(_ name: String, _ value: String) -> RFC_2046.BodyPart {
        RFC_2046.BodyPart(
            headers: RFC_2046.BodyPart.Headers(contentDisposition: .formData(name: name)),
            content: RFC_2046.BodyPart.Content(value)
        )
    }

    /// A `multipart/form-data` file field — matching the archived router's
    /// `addFileField`. An unparseable `contentType` string is dropped rather
    /// than failing the whole request, the same silent `try?` the archived
    /// router used.
    fileprivate static func fileField(
        _ name: String,
        filename: String,
        contentType: String?,
        data: [UInt8]
    ) -> RFC_2046.BodyPart {
        RFC_2046.BodyPart(
            headers: RFC_2046.BodyPart.Headers(
                contentDisposition: .formData(name: name, filename: try? RFC_2183.Filename(filename)),
                contentType: contentType.flatMap { try? RFC_2045.ContentType($0) }
            ),
            content: RFC_2046.BodyPart.Content(binary: data.map(Byte.init))
        )
    }

    /// `template`/`t:version`/`t:text`/`t:variables` — identical across
    /// `send` and `sendMime`.
    fileprivate static func templateParts(
        template: String?,
        templateVersion: String?,
        templateText: Bool?,
        templateVariables: String?
    ) -> [RFC_2046.BodyPart] {
        var parts: [RFC_2046.BodyPart] = []
        if let template { parts.append(Self.field("template", template)) }
        if let templateVersion { parts.append(Self.field("t:version", templateVersion)) }
        if let templateText { parts.append(Self.field("t:text", templateText ? "yes" : "no")) }
        if let templateVariables { parts.append(Self.field("t:variables", templateVariables)) }
        return parts
    }

    /// `o:tag` through `recipient-variables` — identical across `send` and
    /// `sendMime`.
    fileprivate static func optionParts(
        tags: [String]?,
        dkim: Bool?,
        secondaryDkim: String?,
        secondaryDkimPublic: String?,
        deliveryTime: Time.Epoch?,
        deliveryTimeOptimizePeriod: String?,
        timeZoneLocalize: String?,
        testMode: Bool?,
        tracking: Mailgun.Messages.Tracking.Option?,
        trackingClicks: Mailgun.Messages.Tracking.Option?,
        trackingOpens: Bool?,
        requireTls: Bool?,
        skipVerification: Bool?,
        sendingIp: String?,
        sendingIpPool: String?,
        trackingPixelLocationTop: Bool?,
        headers: [String: String]?,
        variables: [String: String]?,
        recipientVariables: String?
    ) -> [RFC_2046.BodyPart] {
        var parts: [RFC_2046.BodyPart] = []
        if let tags { for tag in tags { parts.append(Self.field("o:tag", tag)) } }
        if let dkim { parts.append(Self.field("o:dkim", dkim ? "yes" : "no")) }
        if let secondaryDkim { parts.append(Self.field("o:secondary-dkim", secondaryDkim)) }
        if let secondaryDkimPublic {
            parts.append(Self.field("o:secondary-dkim-public", secondaryDkimPublic))
        }
        if let deliveryTime {
            parts.append(Self.field("o:deliverytime", Self.rfc2822(deliveryTime)))
        }
        if let deliveryTimeOptimizePeriod {
            parts.append(Self.field("o:deliverytime-optimize-period", deliveryTimeOptimizePeriod))
        }
        if let timeZoneLocalize {
            parts.append(Self.field("o:time-zone-localize", timeZoneLocalize))
        }
        if let testMode { parts.append(Self.field("o:testmode", testMode ? "yes" : "no")) }
        if let tracking { parts.append(Self.field("o:tracking", tracking.rawValue)) }
        if let trackingClicks {
            parts.append(Self.field("o:tracking-clicks", trackingClicks.rawValue))
        }
        if let trackingOpens {
            parts.append(Self.field("o:tracking-opens", trackingOpens ? "yes" : "no"))
        }
        if let requireTls { parts.append(Self.field("o:require-tls", requireTls ? "yes" : "no")) }
        if let skipVerification {
            parts.append(Self.field("o:skip-verification", skipVerification ? "yes" : "no"))
        }
        if let sendingIp { parts.append(Self.field("o:sending-ip", sendingIp)) }
        if let sendingIpPool { parts.append(Self.field("o:sending-ip-pool", sendingIpPool)) }
        if let trackingPixelLocationTop {
            parts.append(
                Self.field("o:tracking-pixel-location-top", trackingPixelLocationTop ? "yes" : "no")
            )
        }
        if let headers {
            for (key, value) in headers { parts.append(Self.field("h:\(key)", value)) }
        }
        if let variables {
            for (key, value) in variables { parts.append(Self.field("v:\(key)", value)) }
        }
        if let recipientVariables {
            parts.append(Self.field("recipient-variables", recipientVariables))
        }
        return parts
    }

    /// RFC 2822 date-time (`EEE, dd MMM yyyy HH:mm:ss zzz`), matching the
    /// archived router's `DateFormatter` — fixed to UTC explicitly rather
    /// than the archived formatter's implicit system-timezone dependency
    /// (`Time.Epoch` is a UTC instant; no corpus fixture exercises this
    /// field, so there is nothing to diverge from).
    fileprivate static func rfc2822(_ epoch: Time.Epoch) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(
            from: Date(timeIntervalSince1970: Double(epoch.referenceDate.secondsSinceEpoch))
        )
    }

    fileprivate static func parts(
        for request: Mailgun.Messages.Send.Request
    ) -> [RFC_2046.BodyPart] {
        var parts: [RFC_2046.BodyPart] = [Self.field("from", request.from.rawValue)]
        for recipient in request.to { parts.append(Self.field("to", recipient.rawValue)) }
        parts.append(Self.field("subject", request.subject))
        if let html = request.html { parts.append(Self.field("html", html)) }
        if let text = request.text { parts.append(Self.field("text", text)) }
        if let cc = request.cc {
            for recipient in cc { parts.append(Self.field("cc", recipient.rawValue)) }
        }
        if let bcc = request.bcc {
            for recipient in bcc { parts.append(Self.field("bcc", recipient.rawValue)) }
        }
        if let ampHtml = request.ampHtml { parts.append(Self.field("amp-html", ampHtml)) }
        parts.append(
            contentsOf: Self.templateParts(
                template: request.template,
                templateVersion: request.templateVersion,
                templateText: request.templateText,
                templateVariables: request.templateVariables
            )
        )
        if let attachments = request.attachments {
            for attachment in attachments {
                parts.append(
                    Self.fileField(
                        "attachment",
                        filename: attachment.filename,
                        contentType: attachment.contentType,
                        data: attachment.data
                    )
                )
            }
        }
        if let inline = request.inline {
            for attachment in inline {
                parts.append(
                    Self.fileField(
                        "inline",
                        filename: attachment.filename,
                        contentType: attachment.contentType,
                        data: attachment.data
                    )
                )
            }
        }
        parts.append(
            contentsOf: Self.optionParts(
                tags: request.tags,
                dkim: request.dkim,
                secondaryDkim: request.secondaryDkim,
                secondaryDkimPublic: request.secondaryDkimPublic,
                deliveryTime: request.deliveryTime,
                deliveryTimeOptimizePeriod: request.deliveryTimeOptimizePeriod,
                timeZoneLocalize: request.timeZoneLocalize,
                testMode: request.testMode,
                tracking: request.tracking,
                trackingClicks: request.trackingClicks,
                trackingOpens: request.trackingOpens,
                requireTls: request.requireTls,
                skipVerification: request.skipVerification,
                sendingIp: request.sendingIp,
                sendingIpPool: request.sendingIpPool,
                trackingPixelLocationTop: request.trackingPixelLocationTop,
                headers: request.headers,
                variables: request.variables,
                recipientVariables: request.recipientVariables
            )
        )
        return parts
    }

    fileprivate static func parts(
        for request: Mailgun.Messages.Send.Mime.Request
    ) -> [RFC_2046.BodyPart] {
        var parts: [RFC_2046.BodyPart] = []
        for recipient in request.to { parts.append(Self.field("to", recipient.rawValue)) }
        parts.append(
            Self.fileField(
                "message",
                filename: "message",
                contentType: "application/octet-stream",
                data: request.message
            )
        )
        parts.append(
            contentsOf: Self.templateParts(
                template: request.template,
                templateVersion: request.templateVersion,
                templateText: request.templateText,
                templateVariables: request.templateVariables
            )
        )
        parts.append(
            contentsOf: Self.optionParts(
                tags: request.tags,
                dkim: request.dkim,
                secondaryDkim: request.secondaryDkim,
                secondaryDkimPublic: request.secondaryDkimPublic,
                deliveryTime: request.deliveryTime,
                deliveryTimeOptimizePeriod: request.deliveryTimeOptimizePeriod,
                timeZoneLocalize: request.timeZoneLocalize,
                testMode: request.testMode,
                tracking: request.tracking,
                trackingClicks: request.trackingClicks,
                trackingOpens: request.trackingOpens,
                requireTls: request.requireTls,
                skipVerification: request.skipVerification,
                sendingIp: request.sendingIp,
                sendingIpPool: request.sendingIpPool,
                trackingPixelLocationTop: request.trackingPixelLocationTop,
                headers: request.headers,
                variables: request.variables,
                recipientVariables: request.recipientVariables
            )
        )
        return parts
    }

    /// Draws a fresh `Part-<UUID>` boundary (matching the archived router's
    /// `SendMultipartConversion`/`MimeMultipartConversion` exactly — not
    /// `RFC_2046.Boundary.random()`, whose format isn't corpus-verified),
    /// serializes `parts` under it, and installs the result as `request`'s
    /// body.
    fileprivate static func attach(
        _ parts: [RFC_2046.BodyPart],
        into request: inout HTTP.Request
    ) throws(Mailgun.HTTP.Construction.Error) {
        let boundary = try Mailgun.HTTP.Construction.boundary("Part-\(UUID().uuidString)")
        let multipart: RFC_2046.Multipart
        do throws(RFC_2046.Multipart.Error) {
            multipart = try RFC_2046.Multipart(subtype: .formData, parts: parts, boundary: boundary)
        } catch {
            throw .messagesMultipart(String(describing: error))
        }
        var bytes: [Byte] = []
        RFC_2046.Multipart.serialize(multipart, into: &bytes)
        request.body = bytes
        request.headers.removeAll(named: "Content-Type")
        request.headers.append(
            try Mailgun.HTTP.Construction.header(
                "Content-Type",
                multipart.contentType.headerValue
            )
        )
    }
}
