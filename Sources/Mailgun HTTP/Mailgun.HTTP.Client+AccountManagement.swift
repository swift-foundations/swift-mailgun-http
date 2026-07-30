import EmailAddress_Standard
import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.AccountManagement`'s wire constructors to this
    /// client's `send(_:)`, producing the `swift-mailgun`-vended closure-bag
    /// client. Account-level — no domain scoping. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func accountManagement()
        -> Mailgun.AccountManagement.Client<Mailgun.HTTP.Error<ExecutionFailure>>
    {
        .init(
            updateAccount: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.AccountManagement.updateAccount(request)
                }
            },
            getHttpSigningKey: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.AccountManagement.getHttpSigningKey()
                }
            },
            regenerateHttpSigningKey: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.AccountManagement.regenerateHttpSigningKey()
                }
            },
            getSandboxAuthRecipients: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.AccountManagement.getSandboxAuthRecipients()
                }
            },
            addSandboxAuthRecipient: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.AccountManagement.addSandboxAuthRecipient(request)
                }
            },
            deleteSandboxAuthRecipient: { email throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.AccountManagement.deleteSandboxAuthRecipient(email)
                }
            },
            resendActivationEmail: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.AccountManagement.resendActivationEmail()
                }
            },
            getSAMLOrganization: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.AccountManagement.getSAMLOrganization()
                }
            },
            addSAMLOrganization: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.AccountManagement.addSAMLOrganization(request)
                }
            }
        )
    }
}
