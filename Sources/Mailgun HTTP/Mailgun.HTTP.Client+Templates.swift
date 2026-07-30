import Domain_Standard
import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Templates`'s wire constructors to this client's
    /// `send(_:)`. Domain-scoped: `domain` is captured once here rather than
    /// threaded through `swift-mailgun`'s `Mailgun.Templates.Client`, whose
    /// closures carry no domain parameter. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func templates(
        domain: Domain
    ) -> Mailgun.Templates.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            list: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.list(domain, request)
                }
            },
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.create(domain, request)
                }
            },
            deleteAll: { () throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.deleteAll(domain)
                }
            },
            versions: { (templateName, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.versions(domain, templateName, request)
                }
            },
            createVersion: { (templateName, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.createVersion(domain, templateName, request)
                }
            },
            get: { (templateName, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.get(domain, templateName, request)
                }
            },
            update: { (templateName, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.update(domain, templateName, request)
                }
            },
            delete: { templateName throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.delete(domain, templateName)
                }
            },
            getVersion: {
                (templateName, versionName) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.getVersion(domain, templateName, versionName)
                }
            },
            updateVersion: {
                (templateName, versionName, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.updateVersion(
                        domain,
                        templateName,
                        versionName,
                        request
                    )
                }
            },
            deleteVersion: {
                (templateName, versionName) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.deleteVersion(domain, templateName, versionName)
                }
            },
            copyVersion: {
                (
                    templateName,
                    versionName,
                    newVersionName,
                    request
                )
                    throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Templates.copyVersion(
                        domain,
                        templateName,
                        versionName,
                        newVersionName,
                        request
                    )
                }
            }
        )
    }
}
