import Domain_Standard
import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Domains`, `.DKIMSecurity`, `.Keys`, and
    /// `.Tracking`'s wire constructors into the composite
    /// `Mailgun.Domains.Client<Failure>` — `swift-mailgun`'s single
    /// `@dynamicMemberLookup` client covering all four domain-management
    /// sub-resources. See `Mailgun.HTTP.Client.routes()`'s doc comment for
    /// why every closure explicitly annotates `throws(...)`.
    public func domains() -> Mailgun.Domains.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            domains: .init(
                list: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.list(request)
                    }
                },
                create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.create(request)
                    }
                },
                get: { domain throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.get(domain)
                    }
                },
                update: { domain, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.update(domain, request)
                    }
                },
                delete: { domain throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.delete(domain)
                    }
                },
                verify: { domain throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.verify(domain)
                    }
                }
            ),
            dkimSecurity: .init(
                updateRotation: { domain, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.DKIMSecurity.updateRotation(domain, request)
                    }
                },
                rotateManually: { domain throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.DKIMSecurity.rotateManually(domain)
                    }
                }
            ),
            domainKeys: .init(
                list: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Keys.list(request)
                    }
                },
                create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Keys.create(request)
                    }
                },
                delete: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Keys.delete(request)
                    }
                },
                activate: { authorityName, selector throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Keys.activate(
                            authorityName: authorityName,
                            selector: selector
                        )
                    }
                },
                listDomainKeys: { authorityName throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Keys.listDomainKeys(authorityName: authorityName)
                    }
                },
                deactivate: {
                    authorityName,
                    selector throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Keys.deactivate(
                            authorityName: authorityName,
                            selector: selector
                        )
                    }
                },
                setDkimAuthority: {
                    domainName,
                    request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Keys.setDkimAuthority(
                            domainName: domainName,
                            request
                        )
                    }
                },
                setDkimSelector: {
                    domainName,
                    request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Keys.setDkimSelector(
                            domainName: domainName,
                            request
                        )
                    }
                }
            ),
            domainTracking: .init(
                get: { domain throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Tracking.get(domain)
                    }
                },
                updateClick: { domain, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Tracking.updateClick(domain, request)
                    }
                },
                updateOpen: { domain, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Tracking.updateOpen(domain, request)
                    }
                },
                updateUnsubscribe: { domain, request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                    try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                        try Mailgun.HTTP.Domains.Tracking.updateUnsubscribe(domain, request)
                    }
                }
            )
        )
    }
}
