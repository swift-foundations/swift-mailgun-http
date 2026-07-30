import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.IPs`'s wire constructors to this client's
    /// `send(_:)`. Account-level — no domain scoping. `deleteDomainIP`/
    /// `deleteDomainPool` validate the incoming raw `String` domain into the
    /// typed `Domain` the wire constructor needs — `swift-mailgun`'s client
    /// vends a bare `String` there (matching the archived router's untyped
    /// case), unlike every other domain-scoped operation in this package.
    /// See `Mailgun.HTTP.Client.routes()`'s doc comment for why every
    /// closure explicitly annotates `throws(...)`.
    public func ips() -> Mailgun.IPs.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            list: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.list()
                }
            },
            get: { ip throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.get(ip)
                }
            },
            listDomains: { ip throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.listDomains(ip)
                }
            },
            assignDomain: { ip, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.assignDomain(ip, request)
                }
            },
            unassignDomain: { ip, domain throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.unassignDomain(ip, domain: domain)
                }
            },
            assignIPBand: { ip, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.assignIPBand(ip, request)
                }
            },
            requestNew: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.requestNew(request)
                }
            },
            getRequestedIPs: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.getRequestedIPs()
                }
            },
            deleteDomainIP: { domain, ip throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.deleteDomainIP(
                        domain: try Mailgun.HTTP.Construction.domain(domain),
                        ip: ip
                    )
                }
            },
            deleteDomainPool: { domain, ip throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.deleteDomainPool(
                        domain: try Mailgun.HTTP.Construction.domain(domain),
                        ip: ip
                    )
                }
            }
        )
    }

    /// Wires `Mailgun.HTTP.IPs.Warmup`'s wire constructors to this client's
    /// `send(_:)`. IP-scoped — no domain concept.
    public func ipAddressWarmup()
        -> Mailgun.IPAddressWarmup.Client<Mailgun.HTTP.Error<ExecutionFailure>>
    {
        .init(
            list: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.Warmup.list()
                }
            },
            get: { ip throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.Warmup.get(ip)
                }
            },
            create: { ip, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.Warmup.create(ip, request)
                }
            },
            delete: { ip throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPs.Warmup.delete(ip)
                }
            }
        )
    }
}
