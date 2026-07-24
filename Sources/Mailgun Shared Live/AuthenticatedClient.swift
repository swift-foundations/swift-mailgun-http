//
//  AuthenticatedClient.swift
//  swift-mailgun-live — Mailgun Shared Live
//

import Dependencies
import Foundation
import URL_Routing_Foundation_Integration
import URLRouting

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public typealias Authenticated<
    API: Equatable & Sendable,
    APIRouter: ParserPrinter & Sendable,
    Client: Sendable
> = Authentication.Client<
    RFC_7617.Basic,
    RFC_7617.Basic.Router,
    API,
    APIRouter,
    Client
> where APIRouter.Output == API, APIRouter.Input == RFC_3986.URI.Request.Data

extension Authentication.Client
where Credential == RFC_7617.Basic, CredentialRouter == RFC_7617.Basic.Router, APIRouter: Sendable {
    public init(
        router: APIRouter,
        buildClient:
            @escaping @Sendable (@escaping @Sendable (API) throws -> URLRequest) -> Consumer
    ) throws {
        @Dependency(\.envVars.mailgun.baseUrl) var baseUrl
        @Dependency(\.envVars.mailgun.apiKey) var apiKey

        self = try .init(
            baseURL: baseUrl,
            credential: .init(userID: "api", password: apiKey.rawValue),
            apiRouter: router,
            credentialRouter: RFC_7617.Basic.Router(),
            client: buildClient
        )
    }
}

extension Authentication.Client
where Credential == RFC_7617.Basic, CredentialRouter == RFC_7617.Basic.Router, APIRouter: Sendable {
    package static func fromEnvironmentVariables(
        router: APIRouter,
        buildClient:
            @escaping @Sendable (
                _ makeRequest: @escaping @Sendable (_ route: API) throws -> URLRequest
            ) -> Consumer
    ) throws -> Self {
        return try .init(
            router: router,
            buildClient: { buildClient($0) }
        )
    }
}

extension Authentication.Client
where
    Credential == RFC_7617.Basic,
    CredentialRouter == RFC_7617.Basic.Router,
    APIRouter: Dependency.Key,
    APIRouter.Value == APIRouter {
    package init(
        buildClient: @escaping @Sendable () -> Consumer
    ) throws {
        @Dependency(APIRouter.self) var router
        self = try .fromEnvironmentVariables(
            router: router
        ) { _ in buildClient() }
    }
}

extension Authentication.Client
where
    Credential == RFC_7617.Basic,
    CredentialRouter == RFC_7617.Basic.Router,
    APIRouter: Dependency.Key,
    APIRouter.Value == APIRouter {
    package init(
        _ buildClient:
            @escaping @Sendable (
                _ makeRequest: @escaping @Sendable (_ route: API) throws -> URLRequest
            ) -> Consumer
    ) throws {
        @Dependency(APIRouter.self) var router
        self = try .fromEnvironmentVariables(
            router: router,
            buildClient: buildClient
        )
    }
}
