import HTML_Form_Coder_Codable
import HTML_Standard

/// The two `application/x-www-form-urlencoded` encoder shapes the Mailgun API
/// wire format uses, ported from the archived `Mailgun Types Shared/Form.Coder.swift`
/// (`swift-mailgun-standard` commit `15f7f18`).
///
/// `yes` / `no` was the original assumption for every boolean form field
/// (`o:testmode`, `o:dkim`, `o:tracking`, ...), but the corpus is authoritative
/// per resource, not a fixed convention across the whole API: `Domains`,
/// `Domains.Tracking`, `Domains.DKIMSecurity`, and `Credentials` all render
/// booleans as literal `true` / `false` instead (see e.g. `Domains.txt`'s
/// `create` case, `wildcard=true`) — `mailgunLiteralBool` covers that shape.
/// Array rendering is the other axis the per-operation corpus fixture
/// decides: most resources repeat the key (`action=a&action=b`);
/// `Mailgun.Webhooks` needs `key[]=` bracket rendering instead (see
/// `Webhooks.txt`). Date and binary-data fields are absent from every request
/// DTO this package currently constructs, so those strategies stay at their
/// harmless defaults rather than pulling in a Foundation-based formatter.
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

    /// Repeated-bare-key array rendering (same as `.mailgun`) with literal
    /// `true` / `false` booleans instead of `yes` / `no` — the shape
    /// `Domains`, `Domains.Tracking`, `Domains.DKIMSecurity`, `Credentials`,
    /// `IPs.Warmup`, and `Subaccounts.updateFeatures` corpus fixtures
    /// require.
    static var mailgunLiteralBool: HTML.Form.Coder.Encoder {
        HTML.Form.Coder.Encoder(arrayEncodingStrategy: .accumulateValues)
    }

    /// `key[]=value` array rendering (same as `.mailgunBracketed`) with
    /// literal `true` / `false` booleans instead of `yes` / `no` — the shape
    /// `Lists.bulkAdd`'s root array-of-members body requires (each element
    /// renders as `[][field]=value`).
    static var mailgunBracketedLiteralBool: HTML.Form.Coder.Encoder {
        HTML.Form.Coder.Encoder(arrayEncodingStrategy: .brackets)
    }
}
