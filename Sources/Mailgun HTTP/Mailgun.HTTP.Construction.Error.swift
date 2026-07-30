import Domain_Standard
import HTML_Form_Coder
import HTML_Form_Coder_Codable
import HTML_Standard
import HTTP_Standard
import RFC_2046
import RFC_3986

extension Mailgun.HTTP {
    /// Namespace for the pure, unauthenticated wire-request constructors —
    /// one nested enum per Mailgun resource (`Mailgun.HTTP.Routes`,
    /// `Mailgun.HTTP.Messages`, ...), each mirroring the corresponding
    /// `Mailgun.<Resource>` namespace vended by `swift-mailgun-standard`.
    ///
    /// These constructors never touch authentication or the API host — see
    /// `Mailgun.HTTP.Client.authenticated(_:)` for that. They build exactly the
    /// method, path, query, headers, and body under test in
    /// `Tests/Mailgun HTTP Tests/__Corpus__`.
    public enum Construction: Sendable {}
}

extension Mailgun.HTTP.Construction {
    /// Every failure mode a wire-request constructor can raise.
    public enum Error: Swift.Error, Sendable {
        /// A path segment was not RFC 3986 path legal.
        case path(RFC_3986.URI.Path.Error)

        /// A query parameter was not RFC 3986 query legal.
        case query(RFC_3986.URI.Query.Error)

        /// A multipart boundary was not RFC 2046 boundary legal.
        case boundary(RFC_2046.Boundary.Error)

        /// A header field's value was not RFC 9110 field-value legal.
        case header(HTTP.Header.Field.Error)

        /// A raw `String` domain name was not a legal `Domain` — only
        /// `Mailgun.HTTP.Client`'s wrapper for `Mailgun.HTTP.IPs.deleteDomainIP`/
        /// `.deleteDomainPool` needs this: `swift-mailgun`'s
        /// `Mailgun.IPs.Client` vends those two operations' domain as a bare
        /// `String` (matching the archived router's untyped case exactly),
        /// while the wire constructor takes the typed `Domain` every other
        /// domain-scoped operation in this package uses.
        case domain(Domain.Error)

        /// Form or multipart body encoding failed.
        case coding(HTML.Form.Coder.Error)

        /// JSON body encoding failed — `Mailgun.Reporting.Logs.analytics` and
        /// `Mailgun.Reporting.Metrics.*`, the only operations in this package
        /// whose wire body is `application/json` rather than
        /// `application/x-www-form-urlencoded` or `multipart/form-data`.
        /// Carries a description rather than the underlying error value,
        /// mirroring `HTML.Form.Coder.Error.coding`'s own `String` case —
        /// the underlying `EncodingError` is not `Sendable`.
        case json(String)

        /// Hand-rolled multipart assembly failed — `Mailgun.HTTP.Messages.send`
        /// and `.sendMime`, which build `RFC_2046.BodyPart`s directly (per
        /// the archived router's `SendMultipartConversion`/`MimeMultipartConversion`)
        /// rather than going through `HTML.Form.Coder.Multipart`.
        case messagesMultipart(String)
    }
}
