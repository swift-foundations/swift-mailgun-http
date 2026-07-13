//
//  Dependency.Values.Context.swift
//  swift-mailgun-live
//
//  Test-support `\.context` shim: the institute Dependencies stack does not vend
//  pointfree's `DependencyValues.context`, so the live/test context selector the
//  test suites set via `.dependency(\.context, .live)` is re-created here. Mirrors
//  swift-github-live's `EnvironmentVariables+Testing.swift` context block.
//
//  `public` (not `package`): consumers of this product — e.g. swift-mailgun's own
//  test targets — are a separate SwiftPM package, and `package` access does not
//  cross that package boundary even though swift-mailgun depends on this product.
//

import Dependencies

extension Dependency.Values {
    public struct Context: Sendable {
        enum ContextType: Sendable {
            case live
            case test
        }

        let type: ContextType

        public static let live = Context(type: .live)
        public static let test = Context(type: .test)
    }

    public var context: Context {
        get { self[ContextKey.self] }
        set { self[ContextKey.self] = newValue }
    }

    private enum ContextKey: Dependency.Key {
        static let liveValue = Context.test
        static let testValue = Context.test
    }
}
