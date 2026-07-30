import Domain_Standard
import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Messages`'s wire constructors to this client's
    /// `send(_:)`. Domain-scoped: `domain` is captured once here rather than
    /// threaded through `swift-mailgun`'s `Mailgun.Messages.Client`, whose
    /// closures carry no domain parameter. `deleteAll` maps to this
    /// package's `deleteScheduled` — same operation
    /// (`DELETE /v3/{domain}/envelopes`), different name (`swift-mailgun`'s
    /// naming for what the archived router calls `deleteScheduled`). See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func messages(
        domain: Domain
    ) -> Mailgun.Messages.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            send: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Messages.send(domain, request)
                }
            },
            sendMime: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Messages.sendMime(domain, request)
                }
            },
            retrieve: { storageKey throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Messages.retrieve(domain, storageKey: storageKey)
                }
            },
            queueStatus: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Messages.queueStatus(domain)
                }
            },
            deleteAll: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Messages.deleteScheduled(domain)
                }
            }
        )
    }
}
