import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Subaccounts`'s wire constructors to this client's
    /// `send(_:)`. Account-level — no domain scoping. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func subaccounts() -> Mailgun.Subaccounts.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            get: { subaccountId throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Subaccounts.get(subaccountId)
                }
            },
            list: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Subaccounts.list(request)
                }
            },
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Subaccounts.create(request)
                }
            },
            delete: { subaccountId throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Subaccounts.delete(subaccountId)
                }
            },
            disable: { subaccountId, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Subaccounts.disable(subaccountId, request)
                }
            },
            enable: { subaccountId throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Subaccounts.enable(subaccountId)
                }
            },
            getCustomLimit: { subaccountId throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Subaccounts.getCustomLimit(subaccountId)
                }
            },
            updateCustomLimit: { subaccountId, limit throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Subaccounts.updateCustomLimit(subaccountId, limit: limit)
                }
            },
            deleteCustomLimit: { subaccountId throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Subaccounts.deleteCustomLimit(subaccountId)
                }
            },
            updateFeatures: { subaccountId, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Subaccounts.updateFeatures(subaccountId, request)
                }
            }
        )
    }
}
