extension Mailgun.HTTP.Construction {
    /// A minimal, outbound-only JSON tree for the handful of operations whose
    /// wire body is `application/json` rather than
    /// `application/x-www-form-urlencoded` or `multipart/form-data`
    /// (`Mailgun.Reporting.Logs.analytics`, whose `Time.Epoch` fields need to
    /// render as bare Unix-epoch-seconds integers rather than the nested
    /// object `Time.Epoch`'s own `Codable` conformance produces).
    ///
    /// Not `RFC_8259.Value`: `swift-json`'s `JSON` target depends on
    /// `swift-async`, which (as of this writing) pulls in `swift-kernel`
    /// completion-port bindings that fail to compile on this toolchain — a
    /// pre-existing, unrelated defect out of scope for this repository to
    /// fix. This tree is built field-by-field the same way every operation
    /// already builds its query parameters, and serialized through
    /// `Foundation.JSONEncoder`'s `.sortedKeys` output formatting (see
    /// `Mailgun.HTTP.Construction.json(_:into:)`) to match every JSON corpus
    /// fixture's `body(utf8/sorted-keys):` byte order.
    enum JSON: Swift.Encodable {
        case string(String)
        case int(Int)
        case double(Double)
        case bool(Bool)
        case array([JSON])
        case object([(String, JSON)])

        struct Key: CodingKey {
            let stringValue: String
            init(_ stringValue: String) { self.stringValue = stringValue }
            init?(stringValue: String) { self.stringValue = stringValue }
            var intValue: Int? { nil }
            init?(intValue: Int) { nil }
        }

        // REASON: `Swift.Encodable.encode(to:)` is declared with untyped
        // `throws` upstream; a conforming implementation is signature-forced
        // and cannot express `throws(E)`.
        // swiftlint:disable:next typed_throws_required
        func encode(to encoder: Swift.Encoder) throws {
            switch self {
            case .string(let value):
                var container = encoder.singleValueContainer()
                try container.encode(value)

            case .int(let value):
                var container = encoder.singleValueContainer()
                try container.encode(value)

            case .double(let value):
                var container = encoder.singleValueContainer()
                try container.encode(value)

            case .bool(let value):
                var container = encoder.singleValueContainer()
                try container.encode(value)

            case .array(let values):
                var container = encoder.unkeyedContainer()
                for value in values { try container.encode(value) }

            case .object(let pairs):
                var container = encoder.container(keyedBy: Key.self)
                for (key, value) in pairs { try container.encode(value, forKey: Key(key)) }
            }
        }
    }
}
