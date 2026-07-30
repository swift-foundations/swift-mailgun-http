import HTTP_Standard

/// Wire-level request construction for `Mailgun.Keys` (docs section "Keys").
///
/// Ported from the archived `Mailgun Keys Types/Keys.API.swift`
/// (`swift-mailgun-standard` commit `15f7f18`) and verified against
/// `Tests/Mailgun HTTP Tests/__Corpus__/Keys.txt`.
extension Mailgun.HTTP {
    public enum Keys: Sendable {}
}

extension Mailgun.HTTP.Keys {
    public static func list() throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.get, ["v1", "keys"])
    }

    public static func create(
        _ request: Mailgun.Keys.Create.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.post, ["v1", "keys"])
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }

    public static func delete(
        _ keyId: String
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        try Mailgun.HTTP.Construction.request(.delete, ["v1", "keys", keyId])
    }

    public static func addPublicKey(
        _ request: Mailgun.Keys.PublicKey.Request
    ) throws(Mailgun.HTTP.Construction.Error) -> HTTP.Request {
        var httpRequest = try Mailgun.HTTP.Construction.request(.post, ["v1", "keys", "public"])
        try Mailgun.HTTP.Construction.form(request, into: &httpRequest)
        return httpRequest
    }
}
