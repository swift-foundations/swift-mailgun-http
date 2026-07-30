import HTML_Form_Coder_Codable
import HTML_Standard

/// The two `application/x-www-form-urlencoded` encoder shapes the Mailgun API
/// wire format uses, ported from the archived `Mailgun Types Shared/Form.Coder.swift`
/// (`swift-mailgun-standard` commit `15f7f18`).
///
/// Both use `yes` / `no` for booleans — the Mailgun API's convention for every
/// boolean form field (`o:testmode`, `o:dkim`, `o:tracking`, ...). They differ
/// only in array rendering, which the per-operation corpus fixture decides:
/// most resources repeat the key (`action=a&action=b`); `Mailgun.Webhooks`
/// needs `key[]=` bracket rendering instead (see `Webhooks.txt`). Date and
/// binary-data fields are absent from every request DTO this package
/// currently constructs, so those strategies stay at their harmless defaults
/// rather than pulling in a Foundation-based formatter.
extension HTML.Form.Coder.Encoder {
    static var mailgun: HTML.Form.Coder.Encoder {
        HTML.Form.Coder.Encoder(
            arrayEncodingStrategy: .accumulateValues,
            boolEncodingStrategy: .yes
        )
    }

    /// The `key[]=value` array rendering some resources use instead of a
    /// repeated bare key (e.g. `Mailgun.Webhooks` — see `Webhooks.txt`).
    static var mailgunBracketed: HTML.Form.Coder.Encoder {
        HTML.Form.Coder.Encoder(
            arrayEncodingStrategy: .brackets,
            boolEncodingStrategy: .yes
        )
    }
}
