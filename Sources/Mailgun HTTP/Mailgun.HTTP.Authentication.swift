extension Mailgun.HTTP {
    /// Mailgun API credentials.
    ///
    /// Every Mailgun REST endpoint authenticates with HTTP Basic using the fixed
    /// username `api` and the account's API key as the password (official
    /// reference, Authentication section).
    public struct Authentication: Equatable, Sendable {
        /// The fixed HTTP Basic username every Mailgun endpoint expects.
        public static let username = "api"

        /// The Mailgun API key, used as the HTTP Basic password.
        public var apiKey: String

        public init(apiKey: String) {
            self.apiKey = apiKey
        }
    }
}

extension Mailgun.HTTP.Authentication {
    /// The RFC 9110 Basic credentials for this API key.
    var credentials: HTTP.Authentication.Credentials {
        .basic(username: Self.username, password: apiKey)
    }
}
