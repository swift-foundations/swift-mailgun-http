/// Namespace for `Mailgun.Reporting`'s wire-level request constructors
/// (docs section "Reporting") — `Events`, `Logs`, `Metrics`, `Stats`, and
/// `Tags`, each in its own nested namespace.
///
/// `Mailgun.Reporting` itself carries no operations of its own in the
/// archived router (`Mailgun Reporting Types/Reporting.API.swift`,
/// `swift-mailgun-standard` commit `15f7f18`) — it only dispatches to its
/// five sub-resources — so this namespace does too.
extension Mailgun.HTTP {
    public enum Reporting: Sendable {}
}
