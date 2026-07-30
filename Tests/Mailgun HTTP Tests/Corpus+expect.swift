import Testing

@testable import Mailgun_HTTP

extension Corpus.Case {
    /// Asserts that `request` — a wire-level request built by one of the
    /// `Mailgun.HTTP.<Resource>` constructors — matches this corpus case's
    /// method, path, query, headers, and body exactly.
    func expect(
        matches request: HTTP.Request,
        sourceLocation: SourceLocation = #_sourceLocation
    ) {
        #expect(request.method.rawValue == method, "method (\(name))", sourceLocation: sourceLocation)
        #expect(
            request.path?.description == path,
            "path (\(name))",
            sourceLocation: sourceLocation
        )

        let actualQuery: [String] =
            request.query?.parameters.map { key, value in
                value.map { "\(key)=\($0)" } ?? key
            } ?? []
        #expect(actualQuery == query, "query (\(name))", sourceLocation: sourceLocation)

        let actualHeaders: [(name: String, value: String)] = request.headers.map {
            ($0.name.rawValue.lowercased(), $0.value.rawValue)
        }
        let actualHeaderNames = actualHeaders.map { $0.name }
        let actualHeaderValues = actualHeaders.map { $0.value }
        let expectedHeaderNames = headers.map { $0.name }
        let expectedHeaderValues = headers.map { $0.value }
        #expect(
            actualHeaderNames == expectedHeaderNames && actualHeaderValues == expectedHeaderValues,
            "headers (\(name)): expected \(headers), got \(actualHeaders)",
            sourceLocation: sourceLocation
        )

        let actualBody = request.body.map { String(decoding: $0.map(\.underlying), as: UTF8.self) }
        #expect(actualBody == body, "body (\(name))", sourceLocation: sourceLocation)
    }
}
