import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Routes`'s wire constructors to this client's
    /// `send(_:)`. Account-level — no domain scoping.
    ///
    /// Every closure below explicitly annotates `throws(...)` at both
    /// levels (the outer closure and the `call` builder closure): Swift
    /// does not propagate an expected typed-throws signature into a closure
    /// literal from context, so without the annotation both default to
    /// untyped `throws` and fail to satisfy `Mailgun.<Resource>.Client`'s
    /// typed-throws stored-closure properties.
    public func routes() -> Mailgun.Routes.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Routes.create(request)
                }
            },
            list: { (limit, skip) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Routes.list(limit: limit, skip: skip)
                }
            },
            get: { id throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Routes.get(id)
                }
            },
            update: { (id, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Routes.update(id, request)
                }
            },
            delete: { id throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Routes.delete(id)
                }
            },
            match: { address throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Routes.match(address)
                }
            }
        )
    }
}
