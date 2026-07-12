//
//  Logs.Client.live.swift
//  swift-mailgun-live
//
//  Created by Claude on 08/01/2025.
//

import Dependencies
import Foundation
@_exported import Mailgun_Reporting_Types
@_exported import Mailgun_Shared_Live

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

extension Mailgun.Reporting.Logs.Client {
    public static func live(
        makeRequest: @escaping @Sendable (_ route: Mailgun.Reporting.Logs.API) throws -> URLRequest
    ) -> Self {
        @Dependency(URLRequest.Handler.Mailgun.self) var handleRequest

        return Self(
            analytics: { request in
                try await handleRequest(
                    for: makeRequest(.analytics(request: request)),
                    decodingTo: Mailgun.Reporting.Logs.Analytics.Response.self
                )
            }
        )
    }
}

extension Mailgun.Reporting.Logs {
    public typealias Authenticated = Mailgun_Shared_Live.Authenticated<
        Mailgun.Reporting.Logs.API,
        Mailgun.Reporting.Logs.API.Router,
        Mailgun.Reporting.Logs.Client
    >
}

extension Mailgun.Reporting.Logs: @retroactive Dependency.Key, @unchecked Sendable {
    public static var liveValue: Mailgun.Reporting.Logs.Authenticated {
        try! Mailgun.Reporting.Logs.Authenticated { .live(makeRequest: $0) }
    }
}

extension Mailgun.Reporting.Logs.API.Router: @retroactive Dependency.Key {
    public static let liveValue: Mailgun.Reporting.Logs.API.Router = .init()
}
