import Domain_Standard
import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Webhooks`'s wire constructors to this client's
    /// `send(_:)`. Domain-scoped: `domain` is captured once here rather than
    /// threaded through `swift-mailgun`'s `Mailgun.Webhooks.Client`, whose
    /// closures carry no domain parameter. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func webhooks(
        domain: Domain
    ) -> Mailgun.Webhooks.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            list: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Webhooks.list(domain)
                }
            },
            get: { webhookName throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Webhooks.get(webhookName, domain: domain)
                }
            },
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Webhooks.create(request, domain: domain)
                }
            },
            update: { (webhookName, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Webhooks.update(webhookName, request, domain: domain)
                }
            },
            delete: { webhookName throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Webhooks.delete(webhookName, domain: domain)
                }
            }
        )
    }
}
