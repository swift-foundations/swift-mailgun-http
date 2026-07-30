import Domain_Standard
import Testing

@testable import Mailgun_HTTP

extension Mailgun.HTTP.IPs {
    @Suite struct Construction {
        @Suite struct Unit {}
    }
}

extension Mailgun.HTTP.IPs.Construction.Unit {
    @Test func `list builds the corpus list request`() throws {
        let request = try Mailgun.HTTP.IPs.list()
        Corpus.load("IPs", case: "list").expect(matches: request)
    }

    @Test func `get builds the corpus get request`() throws {
        let request = try Mailgun.HTTP.IPs.get("192.161.0.1")
        Corpus.load("IPs", case: "get").expect(matches: request)
    }

    @Test func `listDomains builds the corpus listDomains request`() throws {
        let request = try Mailgun.HTTP.IPs.listDomains("192.161.0.1")
        Corpus.load("IPs", case: "listDomains").expect(matches: request)
    }

    @Test func `assignDomain builds the corpus assignDomain request`() throws {
        let request = try Mailgun.HTTP.IPs.assignDomain(
            "192.161.0.1",
            .init(domain: "parity.example.com")
        )
        Corpus.load("IPs", case: "assignDomain").expect(matches: request)
    }

    @Test func `unassignDomain builds the corpus unassignDomain request`() throws {
        let request = try Mailgun.HTTP.IPs.unassignDomain(
            "192.161.0.1",
            domain: "parity.example.com"
        )
        Corpus.load("IPs", case: "unassignDomain").expect(matches: request)
    }

    @Test func `assignIPBand builds the corpus assignIPBand request`() throws {
        let request = try Mailgun.HTTP.IPs.assignIPBand("192.161.0.1", .init(ipBand: "standard"))
        Corpus.load("IPs", case: "assignIPBand").expect(matches: request)
    }

    @Test func `requestNew builds the corpus requestNew request`() throws {
        let request = try Mailgun.HTTP.IPs.requestNew(.init(count: 3))
        Corpus.load("IPs", case: "requestNew").expect(matches: request)
    }

    @Test func `getRequestedIPs builds the corpus getRequestedIPs request`() throws {
        let request = try Mailgun.HTTP.IPs.getRequestedIPs()
        Corpus.load("IPs", case: "getRequestedIPs").expect(matches: request)
    }

    @Test func `deleteDomainIP builds the corpus deleteDomainIP request`() throws {
        let request = try Mailgun.HTTP.IPs.deleteDomainIP(
            domain: try Domain("parity.example.com"),
            ip: "192.161.0.1"
        )
        Corpus.load("IPs", case: "deleteDomainIP").expect(matches: request)
    }

    @Test func `deleteDomainPool builds the corpus deleteDomainPool request`() throws {
        let request = try Mailgun.HTTP.IPs.deleteDomainPool(
            domain: try Domain("parity.example.com"),
            ip: "192.161.0.1"
        )
        Corpus.load("IPs", case: "deleteDomainPool").expect(matches: request)
    }
}
