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
    }
}
