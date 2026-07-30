import EmailAddress_Standard
import HTTP_Standard

extension Mailgun.HTTP.Client {
    /// Wires `Mailgun.HTTP.Lists`'s wire constructors to this client's
    /// `send(_:)`. Lists are identified by their own address, not
    /// domain-scoped. `bulkAddCSV` has no wire constructor to call — see
    /// `Mailgun.HTTP.Lists`'s doc comment on why `bulkAddCSV` was not
    /// ported — and always fails with `Mailgun.HTTP.Error.unsupported`. See
    /// `Mailgun.HTTP.Client.routes()`'s doc comment for why every closure
    /// explicitly annotates `throws(...)`.
    public func lists() -> Mailgun.Lists.Client<Mailgun.HTTP.Error<ExecutionFailure>> {
        .init(
            create: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.create(request)
                }
            },
            list: { request throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.list(request)
                }
            },
            members: { (listAddress, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.members(listAddress, request)
                }
            },
            addMember: { (listAddress, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.addMember(listAddress, request)
                }
            },
            bulkAdd: {
                (listAddress, members, upsert) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.bulkAdd(listAddress, members, upsert: upsert)
                }
            },
            bulkAddCSV: { (_, _, _, _) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                throw Mailgun.HTTP.Error<ExecutionFailure>.unsupported(
                    "Mailgun.HTTP.Lists.bulkAddCSV is not implemented — see swift-mailgun-http#7"
                )
            },
            getMember: {
                (listAddress, memberAddress) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.getMember(listAddress, memberAddress)
                }
            },
            updateMember: {
                (
                    listAddress,
                    memberAddress,
                    request
                ) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.updateMember(listAddress, memberAddress, request)
                }
            },
            deleteMember: {
                (listAddress, memberAddress) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.deleteMember(listAddress, memberAddress)
                }
            },
            update: { (listAddress, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.update(listAddress, request)
                }
            },
            delete: { listAddress throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.delete(listAddress)
                }
            },
            get: { listAddress throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.get(listAddress)
                }
            },
            pages: { limit throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.pages(limit: limit)
                }
            },
            memberPages: { (listAddress, request) throws(Mailgun.HTTP.Error<ExecutionFailure>) in
                try await self.call { () throws(Mailgun.HTTP.Construction.Error) in
                    try Mailgun.HTTP.Lists.memberPages(listAddress, request)
                }
            }
        )
    }
}
