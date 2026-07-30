import Domain_Standard
import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Reporting.Metrics`'s wire constructors to this
    /// client's `send(_:)`. Account-level — no domain scoping. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func reportingMetrics()
        -> Mailgun.Reporting.Metrics.Client<Mailgun.HTTP.Error<ExecutionFailure>>
    {
        .init(
            getAccountMetrics: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Metrics.getAccountMetrics(request)
                }
            },
            getAccountUsageMetrics: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Metrics.getAccountUsageMetrics(request)
                }
            }
        )
    }

    /// Wires `Mailgun.HTTP.Reporting.Stats`'s wire constructors to this
    /// client's `send(_:)`. `total`/`filter` are account-wide; the three
    /// `aggregate*` operations are domain-scoped in the real API (unlike
    /// `swift-mailgun`'s `Mailgun.Reporting.Stats.Client`, whose
    /// `aggregate*` closures take no parameters at all) — `domain` is
    /// captured once here and threaded only into those three.
    public func reportingStats(
        domain: Domain
    ) -> Mailgun.Reporting.Stats.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            total: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Stats.total(request)
                }
            },
            filter: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Stats.filter(request)
                }
            },
            aggregateProviders: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Stats.aggregateProviders(domain)
                }
            },
            aggregateDevices: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Stats.aggregateDevices(domain)
                }
            },
            aggregateCountries: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Stats.aggregateCountries(domain)
                }
            }
        )
    }

    /// Wires `Mailgun.HTTP.Reporting.Events`'s wire constructors to this
    /// client's `send(_:)`. Domain-scoped: `domain` is captured once here
    /// rather than threaded through `swift-mailgun`'s
    /// `Mailgun.Reporting.Events.Client`, whose `list` closure carries no
    /// domain parameter.
    public func reportingEvents(
        domain: Domain
    ) -> Mailgun.Reporting.Events.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            list: { query throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Events.list(domain, query)
                }
            }
        )
    }

    /// Wires `Mailgun.HTTP.Reporting.Tags`'s wire constructors to this
    /// client's `send(_:)`. Domain-scoped: `domain` is captured once here
    /// rather than threaded through `swift-mailgun`'s
    /// `Mailgun.Reporting.Tags.Client`, whose closures carry no domain
    /// parameter.
    public func reportingTags(
        domain: Domain
    ) -> Mailgun.Reporting.Tags.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            list: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Tags.list(domain, request)
                }
            },
            get: { tag throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Tags.get(domain, tag: tag)
                }
            },
            update: { (tag, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Tags.update(domain, tag: tag, request)
                }
            },
            delete: { tag throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Tags.delete(domain, tag: tag)
                }
            },
            stats: { (tag, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Tags.stats(domain, tag: tag, request)
                }
            },
            aggregates: { (tag, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Tags.aggregates(domain, tag: tag, request)
                }
            },
            limits: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Tags.limits(domain)
                }
            }
        )
    }

    /// Wires `Mailgun.HTTP.Reporting.Logs`'s wire constructors to this
    /// client's `send(_:)`. Account-level — no domain scoping.
    public func reportingLogs()
        -> Mailgun.Reporting.Logs.Client<Mailgun.HTTP.Error<ExecutionFailure>>
    {
        .init(
            analytics: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Reporting.Logs.analytics(request)
                }
            }
        )
    }

    /// Composes all five `Mailgun.HTTP.Reporting.*` wrappers into
    /// `swift-mailgun`'s `Mailgun.Reporting.Client<Failure>`.
    public func reporting(
        domain: Domain
    ) -> Mailgun.Reporting.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            metrics: self.reportingMetrics(),
            stats: self.reportingStats(domain: domain),
            events: self.reportingEvents(domain: domain),
            tags: self.reportingTags(domain: domain),
            logs: self.reportingLogs()
        )
    }
}
