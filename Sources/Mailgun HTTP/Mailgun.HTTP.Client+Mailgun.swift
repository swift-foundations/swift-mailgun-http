import Domain_Standard

extension Mailgun.HTTP.Client {
    /// Composes every `Mailgun.HTTP.Client+<Resource>.swift` wrapper into
    /// `swift-mailgun`'s full `Mailgun.Client<Failure>` surface — the
    /// ergonomic, JSON-decoding client for one domain.
    ///
    /// `swift-mailgun`'s `Mailgun.Client` does not surface `dynamicIPPools()`
    /// or `ipAddressWarmup()` at the top level (neither does the upstream
    /// `Mailgun.Client` struct itself); call those directly on this client
    /// when needed.
    public func mailgun(domain: Domain) -> Mailgun.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            messages: self.messages(domain: domain),
            mailingLists: self.lists(),
            events: self.reportingEvents(domain: domain),
            suppressions: self.suppressions(domain: domain),
            webhooks: self.webhooks(domain: domain),
            domains: self.domains(),
            templates: self.templates(domain: domain),
            routes: self.routes(),
            ips: self.ips(),
            ipPools: self.ipPools(),
            ipAllowlist: self.ipAllowlist(),
            keys: self.keys(),
            users: self.users(),
            subaccounts: self.subaccounts(),
            credentials: self.credentials(),
            customMessageLimit: self.customMessageLimit(),
            accountManagement: self.accountManagement(),
            reporting: self.reporting(domain: domain)
        )
    }
}
