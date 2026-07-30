/// Namespace for `Mailgun.Suppressions`'s wire-level request constructors
/// (docs section "Suppressions") — `Bounces`, `Complaints`, `Unsubscribe`,
/// and `Allowlist`, each in its own nested namespace.
///
/// `Mailgun.Suppressions` itself carries no operations of its own in the
/// archived router (`Mailgun Suppressions Types/Suppressions.API.swift`,
/// `swift-mailgun-standard` commit `15f7f18`) — it only dispatches to its
/// four sub-resources — so this namespace does too.
extension Mailgun.HTTP {
    public enum Suppressions: Sendable {}
}
