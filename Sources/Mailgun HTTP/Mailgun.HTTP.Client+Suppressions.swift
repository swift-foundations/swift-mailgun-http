import Domain_Standard
import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Suppressions.Bounces`'s wire constructors to this
    /// client's `send(_:)`. Domain-scoped: `domain` is captured once here.
    /// `importList` has no wire constructor — see
    /// `Mailgun.HTTP.Suppressions.Bounces`'s doc comment — and always fails
    /// with `Mailgun.HTTP.Error.unsupported`. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func suppressionsBounces(
        domain: Domain
    ) -> Mailgun.Suppressions.Bounces.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            importList: { _ throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                throw Mailgun.HTTP.Error<ExecutionFailure>.unsupported(
                    "Mailgun.HTTP.Suppressions.Bounces.importList is not implemented — see swift-mailgun-http#7"
                )
            },
            get: { address throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Bounces.get(domain, address: address)
                }
            },
            delete: { address throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Bounces.delete(domain, address: address)
                }
            },
            list: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Bounces.list(domain, request)
                }
            },
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Bounces.create(domain, request)
                }
            },
            deleteAll: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Bounces.deleteAll(domain)
                }
            }
        )
    }

    /// Wires `Mailgun.HTTP.Suppressions.Complaints`'s wire constructors to
    /// this client's `send(_:)`. Domain-scoped: `domain` is captured once
    /// here. Unlike `Bounces`/`Unsubscribe`/`Allowlist`, `importList` is
    /// fully implemented — see `Mailgun.HTTP.Suppressions.Complaints`.
    public func suppressionsComplaints(
        domain: Domain
    ) -> Mailgun.Suppressions.Complaints.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            importList: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Complaints.importList(domain, request)
                }
            },
            get: { address throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Complaints.get(domain, address: address)
                }
            },
            delete: { address throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Complaints.delete(domain, address: address)
                }
            },
            list: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Complaints.list(domain, request)
                }
            },
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Complaints.create(domain, request)
                }
            },
            deleteAll: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Complaints.deleteAll(domain)
                }
            }
        )
    }

    /// Wires `Mailgun.HTTP.Suppressions.Unsubscribe`'s wire constructors to
    /// this client's `send(_:)`. Domain-scoped: `domain` is captured once
    /// here. `importList` has no wire constructor — see
    /// `Mailgun.HTTP.Suppressions.Unsubscribe`'s doc comment — and always
    /// fails with `Mailgun.HTTP.Error.unsupported`.
    public func suppressionsUnsubscribe(
        domain: Domain
    ) -> Mailgun.Suppressions.Unsubscribe.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            importList: { _ throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                throw Mailgun.HTTP.Error<ExecutionFailure>.unsupported(
                    "Mailgun.HTTP.Suppressions.Unsubscribe.importList is not implemented — see swift-mailgun-http#7"
                )
            },
            get: { address throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Unsubscribe.get(domain, address: address)
                }
            },
            delete: { address throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Unsubscribe.delete(domain, address: address)
                }
            },
            list: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Unsubscribe.list(domain, request)
                }
            },
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Unsubscribe.create(domain, request)
                }
            },
            deleteAll: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Unsubscribe.deleteAll(domain)
                }
            }
        )
    }

    /// Wires `Mailgun.HTTP.Suppressions.Allowlist`'s wire constructors to
    /// this client's `send(_:)`. Domain-scoped: `domain` is captured once
    /// here. `importList` has no wire constructor — see
    /// `Mailgun.HTTP.Suppressions.Allowlist`'s doc comment — and always
    /// fails with `Mailgun.HTTP.Error.unsupported`.
    public func suppressionsAllowlist(
        domain: Domain
    ) -> Mailgun.Suppressions.Allowlist.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            get: { value throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Allowlist.get(domain, value: value)
                }
            },
            delete: { value throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Allowlist.delete(domain, value: value)
                }
            },
            list: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Allowlist.list(domain, request)
                }
            },
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Allowlist.create(domain, request)
                }
            },
            deleteAll: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Suppressions.Allowlist.deleteAll(domain)
                }
            },
            importList: { _ throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                throw Mailgun.HTTP.Error<ExecutionFailure>.unsupported(
                    "Mailgun.HTTP.Suppressions.Allowlist.importList is not implemented — see swift-mailgun-http#7"
                )
            }
        )
    }

    /// Composes all four `Mailgun.HTTP.Suppressions.*` wrappers into
    /// `swift-mailgun`'s `Mailgun.Suppressions.Client<Failure>`.
    public func suppressions(
        domain: Domain
    ) -> Mailgun.Suppressions.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            bounces: self.suppressionsBounces(domain: domain),
            complaints: self.suppressionsComplaints(domain: domain),
            unsubscribe: self.suppressionsUnsubscribe(domain: domain),
            allowlist: self.suppressionsAllowlist(domain: domain)
        )
    }
}
