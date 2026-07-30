import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.IPPools`'s wire constructors to this client's
    /// `send(_:)`. Account-level — no domain scoping. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func ipPools() -> Mailgun.IPPools.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            list: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPPools.list()
                }
            },
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPPools.create(request)
                }
            },
            get: { poolId throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPPools.get(poolId)
                }
            },
            update: { poolId, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPPools.update(poolId, request)
                }
            },
            delete: { poolId, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPPools.delete(poolId, request)
                }
            },
            listDomains: { poolId throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPPools.listDomains(poolId)
                }
            }
        )
    }

    /// Wires `Mailgun.HTTP.IPPools.Dynamic`'s wire constructors to this
    /// client's `send(_:)`. Account-level — no domain scoping.
    public func dynamicIPPools()
        -> Mailgun.DynamicIPPools.Client<Mailgun.HTTP.Error<ExecutionFailure>>
    {
        .init(
            listHistory: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPPools.Dynamic.listHistory(request)
                }
            },
            removeOverride: { domain throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPPools.Dynamic.removeOverride(domain: domain)
                }
            }
        )
    }
}
