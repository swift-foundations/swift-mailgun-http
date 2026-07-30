import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.CustomMessageLimit`'s wire constructors to this
    /// client's `send(_:)`. Account-level — no domain scoping. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func customMessageLimit()
        -> Mailgun.CustomMessageLimit.Client<
            Mailgun.HTTP.Error<ExecutionFailure>
        >
    {
        .init(
            getMonthlyLimit: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.CustomMessageLimit.getMonthlyLimit()
                }
            },
            setMonthlyLimit: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.CustomMessageLimit.setMonthlyLimit(request)
                }
            },
            deleteMonthlyLimit: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.CustomMessageLimit.deleteMonthlyLimit()
                }
            },
            enableAccount: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.CustomMessageLimit.enableAccount()
                }
            }
        )
    }
}
