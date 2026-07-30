extension Mailgun.HTTP {
    /// Widens a `Mailgun.HTTP.Construction.Error` (raised while building a
    /// request) together with a transport failure into a single client-level
    /// error, mirroring the `GitHub.HTTP.Error` shape (`swift-github-http`).
    public enum Error<ExecutionFailure>: Swift.Error, Sendable
    where ExecutionFailure: Swift.Error & Sendable {
        /// Building the wire-level request failed.
        case construction(Mailgun.HTTP.Construction.Error)

        /// The injected transport failed.
        case execute(ExecutionFailure)

        /// The response body did not decode as the expected JSON shape.
        /// Carries a description rather than the underlying `DecodingError`,
        /// which is not `Sendable`.
        case decode(String)

        /// This operation has no corpus-verified wire construction yet —
        /// `Mailgun.HTTP.Lists.bulkAddCSV` and the three random-boundary
        /// `importList` operations
        /// (`Suppressions.Bounces`/`.Unsubscribe`/`.Allowlist`) recorded as
        /// gaps on swift-mailgun-http#7. The closure exists so this
        /// package's `Mailgun.<Resource>.Client<Failure>` factory methods
        /// satisfy the full surface `swift-mailgun` vends; calling it always
        /// fails with this case rather than silently doing the wrong thing.
        case unsupported(String)
    }
}
