import Foundation
import Testing

@testable import Mailgun_HTTP

/// Parses `__Corpus__/<Area>.txt` parity fixtures (ported unchanged from the
/// archived `Mailgun Router Parity Tests` corpus, `swift-mailgun-standard`
/// commit `15f7f18`) and compares them against a constructed `HTTP.Request`.
///
/// Each case block has the shape:
/// ```
/// == <name> ==
/// method: <METHOD>
/// path: <path>
/// query: <key>=<value>       (zero or more, one per parameter)
/// header: <name>: <value>    (zero or more)
/// body: <nil>
///   -- or --
/// body(utf8): <first line of body>
/// <remaining body lines, verbatim, including blank lines>
/// ```
enum Corpus {
    struct Case: Sendable {
        let name: String
        let method: String
        let path: String
        let query: [String]
        let headers: [(name: String, value: String)]
        let body: String?
    }

    /// Loads and parses `__Corpus__/<area>.txt`, sibling to the calling test file.
    static func load(_ area: String, file: StaticString = #filePath) -> [Case] {
        let url = URL(fileURLWithPath: "\(file)")
            .deletingLastPathComponent()
            .appendingPathComponent("__Corpus__")
            .appendingPathComponent("\(area).txt")
        // swiftlint:disable:next force_try
        let text = try! String(contentsOf: url, encoding: .utf8)
        return parse(text)
    }

    /// Looks up a single named case, failing the test immediately if absent —
    /// every constructor test names the corpus case it verifies against.
    static func load(_ area: String, case name: String, file: StaticString = #filePath) -> Case {
        guard let found = load(area, file: file).first(where: { $0.name == name }) else {
            fatalError("No corpus case named '\(name)' in \(area).txt")
        }
        return found
    }

    static func parse(_ text: String) -> [Case] {
        let lines = text.components(separatedBy: "\n")
        var cases: [Case] = []
        var index = 0

        func isDelimiter(_ line: String) -> Bool {
            line.hasPrefix("== ") && line.hasSuffix(" ==")
        }

        while index < lines.count {
            guard isDelimiter(lines[index]) else {
                index += 1
                continue
            }
            let name = String(lines[index].dropFirst(3).dropLast(3))
            index += 1

            var method = ""
            var path = ""
            var query: [String] = []
            var headers: [(name: String, value: String)] = []
            var bodyLines: [String]?

            while index < lines.count, !isDelimiter(lines[index]) {
                let line = lines[index]
                defer { index += 1 }

                if bodyLines != nil {
                    bodyLines!.append(line)
                    continue
                }

                if let value = line.droppingPrefix("method: ") {
                    method = value
                } else if let value = line.droppingPrefix("path: ") {
                    path = value
                } else if let value = line.droppingPrefix("query: ") {
                    query.append(value)
                } else if let value = line.droppingPrefix("header: ") {
                    if let separator = value.range(of: ": ") {
                        headers.append(
                            (
                                name: String(value[value.startIndex..<separator.lowerBound]),
                                value: String(value[separator.upperBound...])
                            )
                        )
                    }
                } else if line == "body: <nil>" {
                    bodyLines = nil
                } else if let value = line.droppingPrefix("body(utf8): ") {
                    bodyLines = [value]
                } else if let value = line.droppingPrefix("body(utf8/sorted-keys): ") {
                    // `Reporting.Logs`/`Reporting.Metrics`: application/json bodies,
                    // captured with keys already sorted alphabetically. The marker
                    // records how the fixture was generated; the body text itself
                    // parses identically to `body(utf8):`.
                    bodyLines = [value]
                }
            }

            var body: String?
            if var collected = bodyLines {
                // The fixture separates cases with one blank line before the next
                // `== name ==` delimiter; that separator is not part of the body.
                if collected.last == "" { collected.removeLast() }
                body = collected.joined(separator: "\n")
            }

            cases.append(
                Case(name: name, method: method, path: path, query: query, headers: headers, body: body)
            )
        }

        return cases
    }
}

extension String {
    fileprivate func droppingPrefix(_ prefix: String) -> String? {
        hasPrefix(prefix) ? String(dropFirst(prefix.count)) : nil
    }
}
