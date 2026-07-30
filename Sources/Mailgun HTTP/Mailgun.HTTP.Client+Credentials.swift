import Domain_Standard
import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Credentials`'s wire constructors to this client's
    /// `send(_:)`. `swift-mailgun`'s closure-bag client carries `domain` as
    /// the first parameter on every operation; this package's wire
    /// constructors take it as a trailing labeled parameter — the adapter
    /// below is only a parameter-order shuffle, not a semantic difference.
    /// See `Mailgun.HTTP.Client.routes()`'s doc comment for why every
    /// closure explicitly annotates `throws(...)`.
    public func credentials() -> Mailgun.Credentials.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            list: { (domain, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Credentials.list(domain: domain, request)
                }
            },
            create: { (domain, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Credentials.create(request, domain: domain)
                }
            },
            deleteAll: { domain throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Credentials.deleteAll(domain: domain)
                }
            },
            update: { (domain, login, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Credentials.update(login, request, domain: domain)
                }
            },
            delete: { (domain, login) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Credentials.delete(login, domain: domain)
                }
            },
            updateMailbox: {
                (domain, login, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Credentials.updateMailbox(login, request, domain: domain)
                }
            }
        )
    }
}
