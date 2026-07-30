/// Convenience namespace for the HTTP-wire construction surface.
///
/// `Mailgun` itself is the shared namespace enum vended by `swift-mailgun-standard`
/// (L2) — the same enum `Mailgun.Routes`, `Mailgun.Messages`, etc. nest under.
/// This package extends it with `Mailgun.HTTP`, the namespace for request
/// construction, authentication, and the wire-execution client.
extension Mailgun {
    public enum HTTP: Sendable {}
}
