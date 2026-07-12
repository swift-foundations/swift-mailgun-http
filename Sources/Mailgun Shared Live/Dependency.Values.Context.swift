//
//  Dependency.Values.Context.swift
//  swift-mailgun-live
//
//  Package-local `\.context` shim: the institute Dependencies stack does not vend
//  pointfree's `DependencyValues.context`, so the live/test context selector the
//  test suites set via `.dependency(\.context, .live)` is re-created here. Mirrors
//  swift-github-live's `EnvironmentVariables+Testing.swift` context block.
//

import Dependencies

extension Dependency.Values {
    package struct Context: Sendable {
        enum ContextType: Sendable {
            case live
            case test
        }

        let type: ContextType

        package static let live = Context(type: .live)
        package static let test = Context(type: .test)
    }

    package var context: Context {
        get { self[ContextKey.self] }
        set { self[ContextKey.self] = newValue }
    }

    private enum ContextKey: Dependency.Key {
        static let liveValue = Context.test
        static let testValue = Context.test
    }
}
