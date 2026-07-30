import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Keys`'s wire constructors to this client's
    /// `send(_:)`. Account-level — no domain scoping. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func keys() -> Mailgun.Keys.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            list: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Keys.list()
                }
            },
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Keys.create(request)
                }
            },
            delete: { keyId throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Keys.delete(keyId)
                }
            },
            addPublicKey: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Keys.addPublicKey(request)
                }
            }
        )
    }
}
