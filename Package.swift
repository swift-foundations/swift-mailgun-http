// swift-tools-version: 6.3.3

import PackageDescription

let package = Package(
    name: "swift-mailgun-http",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Mailgun HTTP",
            targets: ["Mailgun HTTP"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-standards/swift-mailgun-standard.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-standards/swift-domain-standard.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-standards/swift-emailaddress-standard.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-foundations/swift-html-form-coder.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-standards/swift-html-standard.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-foundations/swift-http-body.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-standards/swift-http-standard.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3986.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-2046.git", branch: "main"),
        .package(
            url: "https://github.com/swift-primitives/swift-time-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-byte-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-foundations/swift-mailgun.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Mailgun HTTP",
            dependencies: [
                .product(name: "Mailgun Standard", package: "swift-mailgun-standard"),
                .product(name: "Domain Standard", package: "swift-domain-standard"),
                .product(name: "EmailAddress Standard", package: "swift-emailaddress-standard"),
                .product(name: "HTML Form Coder", package: "swift-html-form-coder"),
                .product(name: "HTML Form Coder Codable", package: "swift-html-form-coder"),
                .product(name: "HTML Standard", package: "swift-html-standard"),
                .product(name: "HTTP Body", package: "swift-http-body"),
                .product(name: "HTTP Standard", package: "swift-http-standard"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "RFC 2046", package: "swift-rfc-2046"),
                .product(name: "Time Primitive", package: "swift-time-primitives"),
                .product(name: "Byte Primitive", package: "swift-byte-primitives"),
                .product(name: "Mailgun", package: "swift-mailgun"),
            ]
        ),
        .testTarget(
            name: "Mailgun HTTP Tests",
            dependencies: ["Mailgun HTTP"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
