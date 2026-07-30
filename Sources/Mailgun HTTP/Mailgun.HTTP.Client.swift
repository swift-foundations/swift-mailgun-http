import HTTP_Standard
import RFC_3986

extension Mailgun.HTTP {
    /// The live wire-execution client: attaches host and credentials to
    /// requests built by the `Mailgun.HTTP.<Resource>` constructors, and hands
    /// them to an injected transport.
    ///
    /// Mirrors the `GitHub.HTTP.Client` shape (`swift-github-http`): a plain
    /// `Sendable` value holding configuration plus an `execute` closure, so any
    /// transport (URLSession, a test double, a server-side HTTP client) can
    /// back it without this package depending on one.
    public struct Client<ExecutionFailure>: Sendable
    where ExecutionFailure: Swift.Error & Sendable {
        /// The Mailgun API host this client addresses (`api.mailgun.net` for the
        /// US region, `api.eu.mailgun.net` for the EU region).
        public var host: RFC_3986.URI.Host

        /// This client's Mailgun API credentials.
        public var authentication: Mailgun.HTTP.Authentication

        /// The transport that turns a constructed `HTTP.Request` into an
        /// `HTTP.Response`.
        public var execute: @Sendable (HTTP.Request) async throws(ExecutionFailure) -> HTTP.Response

        /// The `Authorization` header field, built once from `authentication`
        /// rather than re-encoded on every request (amendment A4).
        let authorizationHeader: HTTP.Header.Field

        public init(
            host: RFC_3986.URI.Host = .registeredName("api.mailgun.net"),
            authentication: Mailgun.HTTP.Authentication,
            execute: @escaping @Sendable (HTTP.Request) async throws(ExecutionFailure) -> HTTP.Response
        ) {
            self.host = host
            self.authentication = authentication
            self.execute = execute
            // "Basic " + base64("api:<key>") is always composed of the base64
            // alphabet plus a space, which is always RFC 9110 field-value legal —
            // this can never actually throw.
            self.authorizationHeader = try! HTTP.Header.Field(
                name: "Authorization",
                value: authentication.credentials.headerValue
            )
        }
    }
}
