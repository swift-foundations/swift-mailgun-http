import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.IPAllowlist`'s wire constructors to this client's
    /// `send(_:)`. Account-level — no domain scoping. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func ipAllowlist() -> Mailgun.IPAllowlist.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            list: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPAllowlist.list()
                }
            },
            update: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPAllowlist.update(request)
                }
            },
            add: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPAllowlist.add(request)
                }
            },
            delete: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.IPAllowlist.delete(request)
                }
            }
        )
    }
}
