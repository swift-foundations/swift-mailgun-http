import HTTP_Standard
import RFC_3986

extension Mailgun.HTTP.Client {
    /// Resolves a wire-constructed request (origin-form, unauthenticated —
    /// the shape every `Mailgun.HTTP.<Resource>` constructor returns) against
    /// this client's `host`, and attaches the cached `Authorization` header.
    ///
    /// Query and body are carried through unchanged; only the target form and
    /// headers change.
    public func authenticated(_ request: HTTP.Request) -> HTTP.Request {
        var request = request
        request.headers.append(authorizationHeader)
        if let path = request.path {
            request.target = .absolute(
                RFC_3986.URI(
                    // swiftlint:disable:next force_try
                    scheme: try! .init("https"),
                    authority: .init(host: host),
                    path: path,
                    query: request.query
                )
            )
        }
        return request
    }

    /// Authenticates and sends a wire-constructed request, returning the raw
    /// response unparsed.
    public func send(
        _ request: HTTP.Request
    ) async throws(Mailgun.HTTP.Error<ExecutionFailure>) -> HTTP.Response {
        do throws(ExecutionFailure) {
            return try await execute(authenticated(request))
        } catch {
            throw .execute(error)
        }
    }
}
