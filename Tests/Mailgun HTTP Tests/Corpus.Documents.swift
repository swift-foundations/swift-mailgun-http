// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-foundations open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-foundations
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension Corpus {
    /// Swift-embedded parity corpus documents, keyed by fixture basename.
    ///
    /// Generated from the former `__Corpus__/<name>.txt` resource files;
    /// each document is byte-identical to the fixture it replaced.
    enum Documents {}
}

extension Corpus.Documents {
    /// The document stored under `name`, if any.
    static subscript(_ name: String) -> String? {
        documents[name]
    }
}

extension Corpus.Documents {
    /// Carried by interpolation: Swift normalizes a
    /// literal carriage return to a line feed inside a
    /// multiline string literal.
    fileprivate static let carriageReturn = "\r"
}

extension Corpus.Documents {
    fileprivate static let documents: [String: String] = [
        "AccountManagement": ##########"""
        == updateAccount ==
        method: PUT
        path: /v5/accounts
        query: name=Parity Account
        query: inactive_session_timeout=900
        query: absolute_session_timeout=86400
        query: logout_redirect_url=https://parity.example.com/logout
        body: <nil>

        == getHttpSigningKey ==
        method: GET
        path: /v5/accounts/http_signing_key
        body: <nil>

        == regenerateHttpSigningKey ==
        method: POST
        path: /v5/accounts/http_signing_key
        body: <nil>

        == getSandboxAuthRecipients ==
        method: GET
        path: /v5/sandbox/auth_recipients
        body: <nil>

        == addSandboxAuthRecipient ==
        method: POST
        path: /v5/sandbox/auth_recipients
        query: email=recipient@parity.example.com
        body: <nil>

        == deleteSandboxAuthRecipient ==
        method: DELETE
        path: /v5/sandbox/auth_recipients/recipient@parity.example.com
        body: <nil>

        == resendActivationEmail ==
        method: POST
        path: /v5/accounts/resend_activation_email
        body: <nil>

        == getSAMLOrganization ==
        method: GET
        path: /v5/accounts/saml_org
        body: <nil>

        == addSAMLOrganization ==
        method: POST
        path: /v5/accounts/saml_org
        query: user_id=user-1234
        query: domain=parity.example.com
        body: <nil>
        """########## + "\n",
        "Credentials": ##########"""
        == list-nil ==
        method: GET
        path: /v3/domains/parity.example.com/credentials
        body: <nil>

        == list-full ==
        method: GET
        path: /v3/domains/parity.example.com/credentials
        query: skip=10
        query: limit=25
        body: <nil>

        == create ==
        method: POST
        path: /v3/domains/parity.example.com/credentials
        header: content-type: application/x-www-form-urlencoded
        body(utf8): login=alice%40parity.example.com&mailbox=alice&password=fixed-parity-password&system=false

        == deleteAll ==
        method: DELETE
        path: /v3/domains/parity.example.com/credentials
        body: <nil>

        == update ==
        method: PUT
        path: /v3/domains/parity.example.com/credentials/alice@parity.example.com
        header: content-type: application/x-www-form-urlencoded
        body(utf8): password=new-fixed-password

        == delete ==
        method: DELETE
        path: /v3/domains/parity.example.com/credentials/alice@parity.example.com
        body: <nil>

        == updateMailbox ==
        method: PUT
        path: /v3/parity.example.com/mailboxes/alice@parity.example.com
        header: content-type: application/x-www-form-urlencoded
        body(utf8): password=mailbox-fixed-password
        """########## + "\n",
        "CustomMessageLimit": ##########"""
        == getMonthly ==
        method: GET
        path: /v5/accounts/limit/custom/monthly
        body: <nil>

        == setMonthly ==
        method: PUT
        path: /v5/accounts/limit/custom/monthly
        query: limit=50000
        body: <nil>

        == deleteMonthly ==
        method: DELETE
        path: /v5/accounts/limit/custom/monthly
        body: <nil>

        == enableAccount ==
        method: PUT
        path: /v5/accounts/limit/custom/enable
        body: <nil>
        """########## + "\n",
        "Domains.DKIMSecurity": ##########"""
        == updateRotation ==
        method: PUT
        path: /v1/dkim_management/domains/parity.example.com/rotation
        header: content-type: application/x-www-form-urlencoded
        body(utf8): rotation_enabled=true&rotation_interval=5d

        == rotateManually ==
        method: POST
        path: /v1/dkim_management/domains/parity.example.com/rotate
        body: <nil>
        """########## + "\n",
        "Domains.Keys": ##########"""
        == list-nil ==
        method: GET
        path: /v1/dkim/keys
        body: <nil>

        == list-full ==
        method: GET
        path: /v1/dkim/keys
        query: page=next-page-token
        query: limit=10
        query: signing_domain=parity.example.com
        query: selector=parity-selector
        body: <nil>

        == create ==
        method: POST
        path: /v1/dkim/keys
        header: content-type: application/x-www-form-urlencoded
        body(utf8): bits=2048&pem=-----BEGIN+PRIVATE+KEY-----PARITYFIXTURE-----END+PRIVATE+KEY-----&selector=parity-selector&signing_domain=parity.example.com

        == delete ==
        method: DELETE
        path: /v1/dkim/keys
        header: content-type: application/x-www-form-urlencoded
        body(utf8): selector=parity-selector&signing_domain=parity.example.com

        == activate ==
        method: PUT
        path: /v4/domains/parity.example.com/keys/parity-selector/activate
        body: <nil>

        == listDomainKeys ==
        method: GET
        path: /v4/domains/parity.example.com/keys
        body: <nil>

        == deactivate ==
        method: PUT
        path: /v4/domains/parity.example.com/keys/parity-selector/deactivate
        body: <nil>

        == setDkimAuthority ==
        method: PUT
        path: /v3/domains/parity.example.com/dkim_authority
        header: content-type: application/x-www-form-urlencoded
        body(utf8): dkim_authority=authority.example.com

        == setDkimSelector ==
        method: PUT
        path: /v3/domains/parity.example.com/dkim_selector
        header: content-type: application/x-www-form-urlencoded
        body(utf8): dkim_selector=parity-selector
        """########## + "\n",
        "Domains.Tracking": ##########"""
        == get ==
        method: GET
        path: /v3/domains/parity.example.com/tracking
        body: <nil>

        == updateClick ==
        method: PUT
        path: /v3/domains/parity.example.com/tracking/click
        header: content-type: application/x-www-form-urlencoded
        body(utf8): active=true

        == updateOpen ==
        method: PUT
        path: /v3/domains/parity.example.com/tracking/open
        header: content-type: application/x-www-form-urlencoded
        body(utf8): active=false

        == updateUnsubscribe ==
        method: PUT
        path: /v3/domains/parity.example.com/tracking/unsubscribe
        header: content-type: application/x-www-form-urlencoded
        body(utf8): active=true&html_footer=%3Cp%3EUnsubscribe+%3Ca+href%3D%22%25unsubscribe_url%25%22%3Ehere%3C%2Fa%3E%3C%2Fp%3E&text_footer=Unsubscribe%3A+%25unsubscribe_url%25
        """########## + "\n",
        "Domains": ##########"""
        == list-nil ==
        method: GET
        path: /v4/domains
        body: <nil>

        == list-full ==
        method: GET
        path: /v4/domains
        query: authority=authority.example.com
        query: state=active
        query: limit=25
        query: skip=5
        body: <nil>

        == create ==
        method: POST
        path: /v4/domains
        header: content-type: application/x-www-form-urlencoded
        body(utf8): dkim_key_size=2048&force_dkim_authority=false&ips=203.0.113.1%2C203.0.113.2&name=parity.example.com&pool_id=pool-parity-1&smtp_password=parity-smtp-password&spam_action=tag&web_scheme=https&wildcard=true

        == get ==
        method: GET
        path: /v4/domains/parity.example.com
        body: <nil>

        == update ==
        method: PUT
        path: /v4/domains/parity.example.com
        header: content-type: application/x-www-form-urlencoded
        body(utf8): spam_action=block&web_scheme=https&wildcard=false

        == delete ==
        method: DELETE
        path: /v4/domains/parity.example.com
        body: <nil>

        == verify ==
        method: PUT
        path: /v4/domains/parity.example.com/verify
        body: <nil>
        """########## + "\n",
        "IPAllowlist": ##########"""
        == list ==
        method: GET
        path: /v2/ip_allowlist
        body: <nil>

        == update ==
        method: PUT
        path: /v2/ip_allowlist
        header: content-type: application/x-www-form-urlencoded
        body(utf8): address=203.0.113.10%2F32&description=Parity+updated+allowlist+entry

        == add ==
        method: POST
        path: /v2/ip_allowlist
        header: content-type: application/x-www-form-urlencoded
        body(utf8): address=203.0.113.10%2F32&description=Parity+allowlist+entry

        == delete ==
        method: DELETE
        path: /v2/ip_allowlist
        header: content-type: application/x-www-form-urlencoded
        body(utf8): address=203.0.113.10%2F32
        """########## + "\n",
        "IPPools.Dynamic": ##########"""
        == listHistory.full ==
        method: GET
        path: /v1/dynamic_pools/history
        query: Limit=25
        query: include_subaccounts=true
        query: domain=parity.example.com
        query: before=cursor-before
        query: after=cursor-after
        query: moved_to=pool-b
        query: moved_from=pool-a
        body: <nil>

        == listHistory.empty ==
        method: GET
        path: /v1/dynamic_pools/history
        body: <nil>

        == removeOverride ==
        method: DELETE
        path: /v1/dynamic_pools/domains/parity.example.com/override
        body: <nil>
        """########## + "\n",
        "IPPools": ##########"""
        == list ==
        method: GET
        path: /v1/ip_pools
        body: <nil>

        == create ==
        method: POST
        path: /v1/ip_pools
        header: content-type: application/x-www-form-urlencoded
        body(utf8): description=Parity+fixture+pool&ips[]=192.161.0.1&ips[]=192.161.0.2&name=parity-pool

        == get ==
        method: GET
        path: /v1/ip_pools/parity-pool-id
        body: <nil>

        == update ==
        method: PATCH
        path: /v1/ip_pools/parity-pool-id
        header: content-type: application/x-www-form-urlencoded
        body(utf8): add_ips[]=192.161.0.3&description=Updated+parity+fixture+pool&name=parity-pool-renamed&remove_ips[]=192.161.0.1

        == delete.query ==
        method: DELETE
        path: /v1/ip_pools/parity-pool-id
        query: ip=192.161.0.1
        query: pool_id=replacement-pool-id
        body: <nil>

        == delete.bare ==
        method: DELETE
        path: /v1/ip_pools/parity-pool-id
        body: <nil>

        == listDomains ==
        method: GET
        path: /v1/ip_pools/parity-pool-id/domains
        body: <nil>
        """########## + "\n",
        "IPs.Warmup": ##########"""
        == list ==
        method: GET
        path: /v3/ip_warmups
        body: <nil>

        == get ==
        method: GET
        path: /v3/ip_warmups/192.161.0.1
        body: <nil>

        == create.full ==
        method: POST
        path: /v3/ip_warmups/192.161.0.1
        header: content-type: application/x-www-form-urlencoded
        body(utf8): enabled=true&volume_daily_capacity=1000

        == create.empty ==
        method: POST
        path: /v3/ip_warmups/192.161.0.1
        header: content-type: application/x-www-form-urlencoded
        body(utf8): 

        == delete ==
        method: DELETE
        path: /v3/ip_warmups/192.161.0.1
        body: <nil>
        """########## + "\n",
        "IPs": ##########"""
        == list ==
        method: GET
        path: /v3/ips
        body: <nil>

        == get ==
        method: GET
        path: /v3/ips/192.161.0.1
        body: <nil>

        == listDomains ==
        method: GET
        path: /v3/ips/192.161.0.1/domains
        body: <nil>

        == assignDomain ==
        method: POST
        path: /v3/ips/192.161.0.1/domains
        header: content-type: application/x-www-form-urlencoded
        body(utf8): domain=parity.example.com

        == unassignDomain ==
        method: DELETE
        path: /v3/ips/192.161.0.1/domains/parity.example.com
        body: <nil>

        == assignIPBand ==
        method: POST
        path: /v3/ips/192.161.0.1/ip_band
        header: content-type: application/x-www-form-urlencoded
        body(utf8): ip_band=standard

        == requestNew ==
        method: POST
        path: /v3/ips/request/new
        header: content-type: application/x-www-form-urlencoded
        body(utf8): count=3

        == getRequestedIPs ==
        method: GET
        path: /v3/ips/request/new
        body: <nil>

        == deleteDomainIP ==
        method: DELETE
        path: /v3/domains/parity.example.com/ips/192.161.0.1
        body: <nil>

        == deleteDomainPool ==
        method: DELETE
        path: /v3/domains/parity.example.com/pool/192.161.0.1
        body: <nil>
        """########## + "\n",
        "KNOWN-NON-ROUNDTRIP": ##########"""
        Batch-0 known non-round-tripping routes on the CURRENT stack (captured, not fixed).
        Format: <Area>.<route name> — reason observed on 2026-07-21, toolchain swift-6.3.3-RELEASE.

        Messages.send — SendMultipartConversion.apply is fatalError (print-only conversion)
        Messages.sendMime — MimeMultipartConversion.apply is fatalError (print-only conversion)

        Optional-request asymmetry (nil request prints an empty query, which parses back
        as a populated all-nil Request value, so parse(print(.x(nil))) != .x(nil)):
        Credentials.list-nil
        Domains.list-nil
        Domains.Keys.list-nil
        IPPools.delete.bare
        Reporting.Events.list.bare
        Reporting.Tags.list.bare
        Subaccounts.disable-nil
        Subaccounts.list-nil
        Templates.copyVersion-nil
        Templates.get-nil
        Templates.list-nil
        Templates.versions-nil
        Users.list-nil

        Parse-side failures (printed request re-parses into an earlier OneOf branch or
        fails outright with a method mismatch inside the OneOf; error thrown on parse):
        Lists.bulkAdd — parse error (method mismatch against earlier GET branch)
        Lists.update — parse error (method mismatch against earlier GET branch)
        Routes.update — parse error (method mismatch against earlier GET branch)
        Routes.match — parsed value differs from printed route
        Suppressions.Allowlist.importList — parsed value differs (multipart body not value-recoverable)
        Suppressions.Bounces.importList — parsed value differs (multipart body not value-recoverable)
        Suppressions.Complaints.importList — parse error (method mismatch against earlier DELETE branch)
        Suppressions.Unsubscribe.importList — parsed value differs (multipart body not value-recoverable)
        """########## + "\n",
        "Keys": ##########"""
        == list ==
        method: GET
        path: /v1/keys
        body: <nil>

        == create ==
        method: POST
        path: /v1/keys
        header: content-type: application/x-www-form-urlencoded
        body(utf8): description=Parity+fixture+key&kind=user&role=admin

        == delete ==
        method: DELETE
        path: /v1/keys/parity-key-id
        body: <nil>

        == addPublicKey ==
        method: POST
        path: /v1/keys/public
        header: content-type: application/x-www-form-urlencoded
        body(utf8): public_key=pubkey-parity-fixture-0123456789
        """########## + "\n",
        "Lists": ##########"""
        == create ==
        method: POST
        path: /v3/lists
        header: content-type: application/x-www-form-urlencoded
        body(utf8): access_level=members&address=developers%40parity.example.com&description=Parity+corpus+list&name=Developers&reply_preference=list

        == list ==
        method: GET
        path: /v3/lists
        query: limit=25
        query: skip=5
        query: address=developers@parity.example.com
        body: <nil>

        == list-empty ==
        method: GET
        path: /v3/lists
        body: <nil>

        == members ==
        method: GET
        path: /v3/lists/developers@parity.example.com/members
        query: address=member@parity.example.com
        query: subscribed=true
        query: limit=10
        query: skip=2
        body: <nil>

        == addMember ==
        method: POST
        path: /v3/lists/developers@parity.example.com/members
        header: content-type: application/x-www-form-urlencoded
        body(utf8): address=new%40parity.example.com&name=New+Member&subscribed=yes&upsert=no&vars[role]=developer

        == bulkAdd ==
        method: POST
        path: /v3/lists/developers@parity.example.com/members.json
        query: upsert=true
        header: content-type: application/x-www-form-urlencoded
        body(utf8): [][address]=bulk1%40parity.example.com&[][name]=Bulk+One&[][subscribed]=true&[][vars][seat]=1&[][address]=bulk2%40parity.example.com&[][name]=Bulk+Two&[][subscribed]=false

        == bulkAddCSV ==
        method: POST
        path: /v3/lists/developers@parity.example.com/members.csv/address,name
        csv@parity.example.com,CSV Member

        query: subscribed=true
        query: upsert=false
        body: <nil>

        == getMember ==
        method: GET
        path: /v3/lists/developers@parity.example.com/members/member@parity.example.com
        body: <nil>

        == updateMember ==
        method: PUT
        path: /v3/lists/developers@parity.example.com/members/member@parity.example.com
        header: content-type: application/x-www-form-urlencoded
        body(utf8): address=renamed%40parity.example.com&name=Renamed+Member&subscribed=no&vars[role]=maintainer

        == deleteMember ==
        method: DELETE
        path: /v3/lists/developers@parity.example.com/members/member@parity.example.com
        body: <nil>

        == update ==
        method: PUT
        path: /v3/lists/developers@parity.example.com
        header: content-type: multipart/form-data; boundary=----MailgunFormBoundary
        body(utf8): ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="address"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        "renamed-list@parity.example.com"\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="description"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        Updated parity list\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="name"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        Renamed List\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="access_level"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        "readonly"\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="reply_reference"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        "sender"\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="list-id"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        parity-list-id\##########(carriageReturn)
        ------MailgunFormBoundary--\##########(carriageReturn)


        == delete ==
        method: DELETE
        path: /v3/lists/developers@parity.example.com
        body: <nil>

        == get ==
        method: GET
        path: /v3/lists/developers@parity.example.com
        body: <nil>

        == pages ==
        method: GET
        path: /v3/lists/pages
        query: limit=50
        body: <nil>

        == pages-empty ==
        method: GET
        path: /v3/lists/pages
        body: <nil>

        == memberPages ==
        method: GET
        path: /v3/lists/developers@parity.example.com/members/pages
        query: subscribed=true
        query: limit=20
        query: address=member@parity.example.com
        query: page=next
        body: <nil>
        """########## + "\n",
        "Messages": ##########"""
        == send ==
        method: POST
        path: /v3/parity.example.com/messages
        header: content-type: multipart/form-data; boundary=Part-<NORMALIZED>
        body(utf8): --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="from"\##########(carriageReturn)
        \##########(carriageReturn)
        sender@parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="to"\##########(carriageReturn)
        \##########(carriageReturn)
        first@parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="to"\##########(carriageReturn)
        \##########(carriageReturn)
        second@parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="subject"\##########(carriageReturn)
        \##########(carriageReturn)
        Parity corpus subject\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="html"\##########(carriageReturn)
        \##########(carriageReturn)
        <h1>Parity</h1><p>Hello</p>\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="text"\##########(carriageReturn)
        \##########(carriageReturn)
        Parity plain text\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="cc"\##########(carriageReturn)
        \##########(carriageReturn)
        cc@parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="bcc"\##########(carriageReturn)
        \##########(carriageReturn)
        bcc@parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="amp-html"\##########(carriageReturn)
        \##########(carriageReturn)
        <html amp4email>Parity AMP</html>\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="template"\##########(carriageReturn)
        \##########(carriageReturn)
        parity-template\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="t:version"\##########(carriageReturn)
        \##########(carriageReturn)
        v2\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="t:text"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="t:variables"\##########(carriageReturn)
        \##########(carriageReturn)
        {"key":"value"}\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; filename="report.txt"; name="attachment"\##########(carriageReturn)
        Content-Type: text/plain\##########(carriageReturn)
        \##########(carriageReturn)
        attachment-bytes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; filename="logo.png"; name="inline"\##########(carriageReturn)
        Content-Type: image/png\##########(carriageReturn)
        \##########(carriageReturn)
        inline-bytes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tag"\##########(carriageReturn)
        \##########(carriageReturn)
        parity\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tag"\##########(carriageReturn)
        \##########(carriageReturn)
        corpus\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:dkim"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:secondary-dkim"\##########(carriageReturn)
        \##########(carriageReturn)
        secondary.parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:secondary-dkim-public"\##########(carriageReturn)
        \##########(carriageReturn)
        public.parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:deliverytime-optimize-period"\##########(carriageReturn)
        \##########(carriageReturn)
        24h\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:time-zone-localize"\##########(carriageReturn)
        \##########(carriageReturn)
        17:00\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:testmode"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tracking"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tracking-clicks"\##########(carriageReturn)
        \##########(carriageReturn)
        htmlonly\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tracking-opens"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:require-tls"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:skip-verification"\##########(carriageReturn)
        \##########(carriageReturn)
        no\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:sending-ip"\##########(carriageReturn)
        \##########(carriageReturn)
        203.0.113.10\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:sending-ip-pool"\##########(carriageReturn)
        \##########(carriageReturn)
        pool-1\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tracking-pixel-location-top"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="h:X-Parity"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="v:campaign"\##########(carriageReturn)
        \##########(carriageReturn)
        parity\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="recipient-variables"\##########(carriageReturn)
        \##########(carriageReturn)
        {"first@parity.example.com":{"id":1}}\##########(carriageReturn)
        --Part-<NORMALIZED>--\##########(carriageReturn)


        == sendMime ==
        method: POST
        path: /v3/parity.example.com/messages.mime
        header: content-type: multipart/form-data; boundary=Part-<NORMALIZED>
        body(utf8): --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="to"\##########(carriageReturn)
        \##########(carriageReturn)
        first@parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="to"\##########(carriageReturn)
        \##########(carriageReturn)
        second@parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; filename="message"; name="message"\##########(carriageReturn)
        Content-Type: application/octet-stream\##########(carriageReturn)
        \##########(carriageReturn)
        From: sender@parity.example.com\##########(carriageReturn)
        Subject: Parity MIME\##########(carriageReturn)
        \##########(carriageReturn)
        Body\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="template"\##########(carriageReturn)
        \##########(carriageReturn)
        parity-template\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="t:version"\##########(carriageReturn)
        \##########(carriageReturn)
        v2\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="t:text"\##########(carriageReturn)
        \##########(carriageReturn)
        no\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="t:variables"\##########(carriageReturn)
        \##########(carriageReturn)
        {"key":"value"}\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tag"\##########(carriageReturn)
        \##########(carriageReturn)
        parity\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tag"\##########(carriageReturn)
        \##########(carriageReturn)
        mime\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:dkim"\##########(carriageReturn)
        \##########(carriageReturn)
        no\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:secondary-dkim"\##########(carriageReturn)
        \##########(carriageReturn)
        secondary.parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:secondary-dkim-public"\##########(carriageReturn)
        \##########(carriageReturn)
        public.parity.example.com\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:deliverytime-optimize-period"\##########(carriageReturn)
        \##########(carriageReturn)
        48h\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:time-zone-localize"\##########(carriageReturn)
        \##########(carriageReturn)
        09:30\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:testmode"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tracking"\##########(carriageReturn)
        \##########(carriageReturn)
        no\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tracking-clicks"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tracking-opens"\##########(carriageReturn)
        \##########(carriageReturn)
        no\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:require-tls"\##########(carriageReturn)
        \##########(carriageReturn)
        no\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:skip-verification"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:sending-ip"\##########(carriageReturn)
        \##########(carriageReturn)
        203.0.113.11\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:sending-ip-pool"\##########(carriageReturn)
        \##########(carriageReturn)
        pool-2\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="o:tracking-pixel-location-top"\##########(carriageReturn)
        \##########(carriageReturn)
        no\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="h:X-Parity-Mime"\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="v:campaign"\##########(carriageReturn)
        \##########(carriageReturn)
        parity-mime\##########(carriageReturn)
        --Part-<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; name="recipient-variables"\##########(carriageReturn)
        \##########(carriageReturn)
        {"second@parity.example.com":{"id":2}}\##########(carriageReturn)
        --Part-<NORMALIZED>--\##########(carriageReturn)


        == retrieve ==
        method: GET
        path: /v3/domains/parity.example.com/messages/storage-key-123
        body: <nil>

        == queueStatus ==
        method: GET
        path: /v3/domains/parity.example.com/sending_queues
        body: <nil>

        == deleteScheduled ==
        method: DELETE
        path: /v3/parity.example.com/envelopes
        body: <nil>
        """########## + "\n",
        "Reporting.Events": ##########"""
        == list.full ==
        method: GET
        path: /v3/parity.example.com/events
        query: begin=1700000000
        query: end=1700086400
        query: ascending=yes
        query: limit=100
        query: event=delivered
        query: list=subscribers@parity.example.com
        query: attachment=report.pdf
        query: from=sender@parity.example.com
        query: message-id=20231113000000.1.PARITYFIXTURE@parity.example.com
        query: subject=Parity fixture subject
        query: to=to@parity.example.com
        query: size=2048
        query: recipient=recipient@parity.example.com
        query: recipients=first@parity.example.com,second@parity.example.com
        query: tags=newsletter,onboarding
        query: severity=permanent
        body: <nil>

        == list.bare ==
        method: GET
        path: /v3/parity.example.com/events
        body: <nil>
        """########## + "\n",
        "Reporting.Logs": ##########"""
        == analytics.full ==
        method: POST
        path: /v1/analytics/logs
        header: content-type: application/json
        body(utf8/sorted-keys): {"action":"delivered","end_date":721779200,"filter":{"and":[{"field":"domain","operator":"=","value":"parity.example.com"}],"or":[{"field":"severity","operator":"!=","value":"temporary"}]},"group_by":"domain","include":["actions","total"],"page":{"number":1,"size":50,"sort":"timestamp:desc"},"start_date":721692800}

        == analytics.empty ==
        method: POST
        path: /v1/analytics/logs
        header: content-type: application/json
        body(utf8/sorted-keys): {}
        """########## + "\n",
        "Reporting.Metrics": ##########"""
        == getAccountMetrics ==
        method: POST
        path: /v1/analytics/metrics
        header: content-type: application/json
        body(utf8/sorted-keys): {"dimensions":["domain"],"duration":"1d","end":"Tue, 14 Nov 2023 00:00:00 +0000","filter":{"AND":[{"attribute":"domain","comparator":"=","values":[{"label":"parity.example.com","value":"parity.example.com"}]}]},"include_aggregates":false,"include_subaccounts":true,"metrics":["accepted_count","delivered_count"],"resolution":"day","start":"Mon, 13 Nov 2023 00:00:00 +0000"}

        == getAccountUsageMetrics ==
        method: POST
        path: /v1/analytics/usage/metrics
        header: content-type: application/json
        body(utf8/sorted-keys): {"dimensions":["subaccount"],"duration":"1d","end":"Tue, 14 Nov 2023 00:00:00 +0000","filter":{"AND":[{"attribute":"domain","comparator":"=","values":[{"label":"parity.example.com","value":"parity.example.com"}]}]},"include_aggregates":true,"include_subaccounts":false,"metrics":["email_validation_count"],"resolution":"day","start":"Mon, 13 Nov 2023 00:00:00 +0000"}
        """########## + "\n",
        "Reporting.Stats": ##########"""
        == total ==
        method: GET
        path: /v3/stats/total
        query: event=delivered
        query: start=Mon, 13 Nov 2023 00:00:00 +0000
        query: end=Tue, 14 Nov 2023 00:00:00 +0000
        query: resolution=day
        query: duration=1d
        body: <nil>

        == total.minimal ==
        method: GET
        path: /v3/stats/total
        query: event=accepted
        body: <nil>

        == filter ==
        method: GET
        path: /v3/stats/filter
        query: event=delivered
        query: start=Mon, 13 Nov 2023 00:00:00 +0000
        query: end=Tue, 14 Nov 2023 00:00:00 +0000
        query: resolution=day
        query: duration=1d
        query: filter=domain=parity.example.com
        query: group=domain
        body: <nil>

        == aggregateProviders ==
        method: GET
        path: /v3/parity.example.com/aggregates/providers
        body: <nil>

        == aggregateDevices ==
        method: GET
        path: /v3/parity.example.com/aggregates/devices
        body: <nil>

        == aggregateCountries ==
        method: GET
        path: /v3/parity.example.com/aggregates/countries
        body: <nil>
        """########## + "\n",
        "Reporting.Tags": ##########"""
        == list.query ==
        method: GET
        path: /v3/parity.example.com/tags
        query: page=next-page-token
        query: limit=25
        body: <nil>

        == list.bare ==
        method: GET
        path: /v3/parity.example.com/tags
        body: <nil>

        == get ==
        method: GET
        path: /v3/parity.example.com/tag
        query: tag=newsletter
        body: <nil>

        == update ==
        method: PUT
        path: /v3/parity.example.com/tag
        query: tag=newsletter
        query: description=Parity fixture tag
        body: <nil>

        == delete ==
        method: DELETE
        path: /v3/parity.example.com/tag
        query: tag=newsletter
        body: <nil>

        == stats ==
        method: GET
        path: /v3/parity.example.com/tag/stats
        query: tag=newsletter
        query: event=accepted,delivered
        query: start=Mon, 13 Nov 2023 00:00:00 +0000
        query: end=Tue, 14 Nov 2023 00:00:00 +0000
        query: resolution=day
        query: duration=1d
        query: provider=gmail.com
        query: device=desktop
        query: country=nl
        body: <nil>

        == aggregates ==
        method: GET
        path: /v3/parity.example.com/tag/stats/aggregates
        query: tag=newsletter
        query: type=providers
        body: <nil>

        == limits ==
        method: GET
        path: /v3/domains/parity.example.com/limits/tag
        body: <nil>
        """########## + "\n",
        "Routes": ##########"""
        == create ==
        method: POST
        path: /v3/routes
        header: content-type: application/x-www-form-urlencoded
        body(utf8): action=forward%28%22https%3A%2F%2Fparity.example.com%2Finbound%22%29&action=stop%28%29&description=Parity+corpus+route&expression=match_recipient%28%22.*%40parity.example.com%22%29&priority=1

        == list ==
        method: GET
        path: /v3/routes
        query: limit=25
        query: skip=5
        body: <nil>

        == list-empty ==
        method: GET
        path: /v3/routes
        body: <nil>

        == get ==
        method: GET
        path: /v3/routes/route-id-123
        body: <nil>

        == update ==
        method: PUT
        path: /v3/routes/route-id-123
        header: content-type: multipart/form-data; boundary=----MailgunFormBoundary
        body(utf8): ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="id"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        route-id-123\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="priority"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        2\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="description"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        Updated parity route\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="expression"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        match_header("subject", ".*parity.*")\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="action"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        store()\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="action"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        stop()\##########(carriageReturn)
        ------MailgunFormBoundary--\##########(carriageReturn)


        == delete ==
        method: DELETE
        path: /v3/routes/route-id-123
        body: <nil>

        == match ==
        method: GET
        path: /v3/routes/match
        query: address=someone@parity.example.com
        body: <nil>
        """########## + "\n",
        "Subaccounts": ##########"""
        == get ==
        method: GET
        path: /v5/accounts/subaccounts/parity-subaccount-id
        body: <nil>

        == list ==
        method: GET
        path: /v5/accounts/subaccounts
        query: sort=asc
        query: filter=parity-filter
        query: limit=10
        query: skip=2
        query: enabled=true
        query: closed=false
        body: <nil>

        == list-nil ==
        method: GET
        path: /v5/accounts/subaccounts
        body: <nil>

        == create ==
        method: POST
        path: /v5/accounts/subaccounts
        query: name=Parity Subaccount
        body: <nil>

        == delete ==
        method: DELETE
        path: /v5/accounts/subaccounts
        header: x-mailgun-on-behalf-of: parity-subaccount-id
        body: <nil>

        == disable ==
        method: POST
        path: /v5/accounts/subaccounts/parity-subaccount-id/disable
        query: reason=abuse
        query: note=parity fixture note
        body: <nil>

        == disable-nil ==
        method: POST
        path: /v5/accounts/subaccounts/parity-subaccount-id/disable
        body: <nil>

        == enable ==
        method: POST
        path: /v5/accounts/subaccounts/parity-subaccount-id/enable
        body: <nil>

        == getCustomLimit ==
        method: GET
        path: /v5/accounts/subaccounts/parity-subaccount-id/limit/custom/monthly
        body: <nil>

        == updateCustomLimit ==
        method: PUT
        path: /v5/accounts/subaccounts/parity-subaccount-id/limit/custom/monthly
        query: limit=50000.0
        body: <nil>

        == deleteCustomLimit ==
        method: DELETE
        path: /v5/accounts/subaccounts/parity-subaccount-id/limit/custom/monthly
        body: <nil>

        == updateFeatures ==
        method: PUT
        path: /v5/accounts/subaccounts/parity-subaccount-id/features
        header: content-type: application/x-www-form-urlencoded
        body(utf8): email_preview[enabled]=true&inbox_placement[enabled]=false&sending[enabled]=true&validations[enabled]=false&validations_bulk[enabled]=true
        """########## + "\n",
        "Suppressions.Allowlist": ##########"""
        == get ==
        method: GET
        path: /v3/parity.example.com/whitelists/user@parity.example.com
        body: <nil>

        == delete ==
        method: DELETE
        path: /v3/parity.example.com/whitelists/user@parity.example.com
        body: <nil>

        == list ==
        method: GET
        path: /v3/parity.example.com/whitelists
        query: address=user@parity.example.com
        query: term=parity-term
        query: limit=25
        query: page=next-page-token
        body: <nil>

        == list-empty ==
        method: GET
        path: /v3/parity.example.com/whitelists
        body: <nil>

        == create-address ==
        method: POST
        path: /v3/parity.example.com/whitelists
        header: content-type: application/x-www-form-urlencoded
        body(utf8): address=user%40parity.example.com

        == create-domain ==
        method: POST
        path: /v3/parity.example.com/whitelists
        header: content-type: application/x-www-form-urlencoded
        body(utf8): domain=allowed.parity.example.com

        == deleteAll ==
        method: DELETE
        path: /v3/parity.example.com/whitelists
        body: <nil>

        == importList ==
        method: POST
        path: /v3/parity.example.com/whitelists/import
        header: content-type: multipart/form-data; boundary=----FormBoundary<NORMALIZED>
        body(utf8): ------FormBoundary<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; filename="import.csv"; name="file"\##########(carriageReturn)
        Content-Type: text/csv\##########(carriageReturn)
        \##########(carriageReturn)
        address
        allowed@parity.example.com
        \##########(carriageReturn)
        ------FormBoundary<NORMALIZED>--\##########(carriageReturn)

        """########## + "\n",
        "Suppressions.Bounces": ##########"""
        == importList ==
        method: POST
        path: /v3/parity.example.com/bounces/import
        header: content-type: multipart/form-data; boundary=----FormBoundary<NORMALIZED>
        body(utf8): ------FormBoundary<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; filename="import.csv"; name="file"\##########(carriageReturn)
        Content-Type: text/csv\##########(carriageReturn)
        \##########(carriageReturn)
        address
        bounced@parity.example.com
        \##########(carriageReturn)
        ------FormBoundary<NORMALIZED>--\##########(carriageReturn)


        == get ==
        method: GET
        path: /v3/parity.example.com/bounces/user@parity.example.com
        body: <nil>

        == delete ==
        method: DELETE
        path: /v3/parity.example.com/bounces/user@parity.example.com
        body: <nil>

        == list ==
        method: GET
        path: /v3/parity.example.com/bounces
        query: limit=25
        query: page=next-page-token
        query: term=parity-term
        body: <nil>

        == list-empty ==
        method: GET
        path: /v3/parity.example.com/bounces
        body: <nil>

        == create ==
        method: POST
        path: /v3/parity.example.com/bounces
        header: content-type: application/x-www-form-urlencoded
        body(utf8): address=user%40parity.example.com&code=550&created_at=Thu%2C+01+Jan+2026+00%3A00%3A00+UTC&error=Mailbox+does+not+exist

        == deleteAll ==
        method: DELETE
        path: /v3/parity.example.com/bounces
        body: <nil>
        """########## + "\n",
        "Suppressions.Complaints": ##########"""
        == importList ==
        method: POST
        path: /v3/parity.example.com/complaints/import
        header: content-type: multipart/form-data; boundary=----MailgunFormBoundary
        body(utf8): ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="file"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        "YWRkcmVzcwpjb21wbGFpbmVkQHBhcml0eS5leGFtcGxlLmNvbQo="\##########(carriageReturn)
        ------MailgunFormBoundary--\##########(carriageReturn)


        == get ==
        method: GET
        path: /v3/parity.example.com/complaints/user@parity.example.com
        body: <nil>

        == delete ==
        method: DELETE
        path: /v3/parity.example.com/complaints/user@parity.example.com
        body: <nil>

        == list ==
        method: GET
        path: /v3/parity.example.com/complaints
        query: address=user@parity.example.com
        query: term=parity-term
        query: limit=25
        query: page=next-page-token
        body: <nil>

        == list-empty ==
        method: GET
        path: /v3/parity.example.com/complaints
        body: <nil>

        == create ==
        method: POST
        path: /v3/parity.example.com/complaints
        header: content-type: application/x-www-form-urlencoded
        body(utf8): address=user%40parity.example.com&created_at=Thu%2C+01+Jan+2026+00%3A00%3A00+UTC

        == deleteAll ==
        method: DELETE
        path: /v3/parity.example.com/complaints
        body: <nil>
        """########## + "\n",
        "Suppressions.Unsubscribe": ##########"""
        == importList ==
        method: POST
        path: /v3/parity.example.com/unsubscribes/import
        header: content-type: multipart/form-data; boundary=----FormBoundary<NORMALIZED>
        body(utf8): ------FormBoundary<NORMALIZED>\##########(carriageReturn)
        Content-Disposition: form-data; filename="import.csv"; name="file"\##########(carriageReturn)
        Content-Type: text/csv\##########(carriageReturn)
        \##########(carriageReturn)
        address
        unsubscribed@parity.example.com
        \##########(carriageReturn)
        ------FormBoundary<NORMALIZED>--\##########(carriageReturn)


        == get ==
        method: GET
        path: /v3/parity.example.com/unsubscribes/user@parity.example.com
        body: <nil>

        == delete ==
        method: DELETE
        path: /v3/parity.example.com/unsubscribes/user@parity.example.com
        body: <nil>

        == list ==
        method: GET
        path: /v3/parity.example.com/unsubscribes
        query: address=user@parity.example.com
        query: term=parity-term
        query: limit=25
        query: page=next-page-token
        body: <nil>

        == list-empty ==
        method: GET
        path: /v3/parity.example.com/unsubscribes
        body: <nil>

        == create ==
        method: POST
        path: /v3/parity.example.com/unsubscribes
        header: content-type: application/x-www-form-urlencoded
        body(utf8): address=user%40parity.example.com&created_at=Thu%2C+01+Jan+2026+00%3A00%3A00+UTC&tags[]=newsletter&tags[]=promotions

        == deleteAll ==
        method: DELETE
        path: /v3/parity.example.com/unsubscribes
        body: <nil>
        """########## + "\n",
        "Templates": ##########"""
        == list-nil ==
        method: GET
        path: /v3/parity.example.com/templates
        body: <nil>

        == list-full ==
        method: GET
        path: /v3/parity.example.com/templates
        query: page=next
        query: limit=25
        query: p=cursor-token
        body: <nil>

        == create ==
        method: POST
        path: /v3/parity.example.com/templates
        header: content-type: multipart/form-data; boundary=----MailgunFormBoundary
        body(utf8): ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="name"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        welcome-template\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="description"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        Welcome email template\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="createdBy"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        parity@example.com\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="template"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        <html>Hello {{name}}</html>\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="tag"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        v1\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="comment"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        initial version\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="headers"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        {"X-Test": "parity"}\##########(carriageReturn)
        ------MailgunFormBoundary--\##########(carriageReturn)


        == deleteAll ==
        method: DELETE
        path: /v3/parity.example.com/templates
        body: <nil>

        == versions-nil ==
        method: GET
        path: /v3/parity.example.com/templates/welcome-template/versions
        body: <nil>

        == versions-full ==
        method: GET
        path: /v3/parity.example.com/templates/welcome-template/versions
        query: page=first
        query: limit=10
        query: p=version-cursor
        body: <nil>

        == createVersion ==
        method: POST
        path: /v3/parity.example.com/templates/welcome-template/versions
        header: content-type: multipart/form-data; boundary=----MailgunFormBoundary
        body(utf8): ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="template"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        <html>Hello v2 {{name}}</html>\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="tag"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        v2\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="comment"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        second version\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="active"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="headers"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        {"X-Test": "parity"}\##########(carriageReturn)
        ------MailgunFormBoundary--\##########(carriageReturn)


        == get-nil ==
        method: GET
        path: /v3/parity.example.com/templates/welcome-template
        body: <nil>

        == get-active ==
        method: GET
        path: /v3/parity.example.com/templates/welcome-template
        query: active=yes
        body: <nil>

        == update ==
        method: PUT
        path: /v3/parity.example.com/templates/welcome-template
        header: content-type: multipart/form-data; boundary=----MailgunFormBoundary
        body(utf8): ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="description"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        Updated description\##########(carriageReturn)
        ------MailgunFormBoundary--\##########(carriageReturn)


        == delete ==
        method: DELETE
        path: /v3/parity.example.com/templates/welcome-template
        body: <nil>

        == getVersion ==
        method: GET
        path: /v3/parity.example.com/templates/welcome-template/versions/v2
        body: <nil>

        == updateVersion ==
        method: PUT
        path: /v3/parity.example.com/templates/welcome-template/versions/v2
        header: content-type: multipart/form-data; boundary=----MailgunFormBoundary
        body(utf8): ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="template"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        <html>Hello v2.1 {{name}}</html>\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="comment"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        tweak copy\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="active"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        yes\##########(carriageReturn)
        ------MailgunFormBoundary\##########(carriageReturn)
        Content-Disposition: form-data; name="headers"\##########(carriageReturn)
        Content-Type: text/plain; charset=UTF-8\##########(carriageReturn)
        \##########(carriageReturn)
        {"X-Test": "parity"}\##########(carriageReturn)
        ------MailgunFormBoundary--\##########(carriageReturn)


        == deleteVersion ==
        method: DELETE
        path: /v3/parity.example.com/templates/welcome-template/versions/v2
        body: <nil>

        == copyVersion-nil ==
        method: PUT
        path: /v3/parity.example.com/templates/welcome-template/versions/v2/copy/v3
        body: <nil>

        == copyVersion-comment ==
        method: PUT
        path: /v3/parity.example.com/templates/welcome-template/versions/v2/copy/v3
        query: comment=copied from v2
        body: <nil>
        """########## + "\n",
        "Users": ##########"""
        == list ==
        method: GET
        path: /v5/users
        query: role=admin
        query: limit=25
        query: skip=5
        body: <nil>

        == list-nil ==
        method: GET
        path: /v5/users
        body: <nil>

        == get ==
        method: GET
        path: /v5/users/parity-user-id
        body: <nil>

        == me ==
        method: GET
        path: /v5/users/me
        body: <nil>

        == addToOrganization ==
        method: PUT
        path: /v5/users/parity-user-id/org/parity-org-id
        body: <nil>

        == removeFromOrganization ==
        method: DELETE
        path: /v5/users/parity-user-id/org/parity-org-id
        body: <nil>
        """########## + "\n",
        "Webhooks": ##########"""
        == list ==
        method: GET
        path: /v3/domains/parity.example.com/webhooks
        body: <nil>

        == get ==
        method: GET
        path: /v3/domains/parity.example.com/webhooks/delivered
        body: <nil>

        == create ==
        method: POST
        path: /v3/domains/parity.example.com/webhooks
        header: content-type: application/x-www-form-urlencoded
        body(utf8): id=opened&url[]=https%3A%2F%2Fparity.example.com%2Fhooks%2Fopened&url[]=https%3A%2F%2Fparity.example.com%2Fhooks%2Fopened-2

        == update ==
        method: PUT
        path: /v3/domains/parity.example.com/webhooks/clicked
        header: content-type: application/x-www-form-urlencoded
        body(utf8): url[]=https%3A%2F%2Fparity.example.com%2Fhooks%2Fclicked

        == delete ==
        method: DELETE
        path: /v3/domains/parity.example.com/webhooks/permanent_fail
        body: <nil>
        """########## + "\n",
    ]
}
