import SwiftUI
import UIKit

/// The two colours this app is allowed to have, and why they are these two.
///
/// Nothing in 2.0 (4) was chosen: every control was system blue at default
/// weight, sitting where SwiftUI put it. Plain is the right answer for an
/// instrument you set face-up on a desk and stop looking at, but plain has to
/// be a decision rather than an absence.
///
/// `within` and `over` are a semantic pair, not decoration. Green below your
/// ceiling and amber above it says which side of your own intention you are on
/// without needing a label, which matters because the person reading it is
/// mid-conversation and not really reading.
///
/// That pair is the app's WHOLE palette. There is no raw `.orange`, `.green`,
/// `.red` or `.blue` anywhere in the views, because an untokenised colour that
/// happens to resemble a token is how two screens end up disagreeing about the
/// same fact — which is exactly what happened before 2026-09-24 (see D-009 in
/// `docs/decisions.md`): Home coloured an under-ceiling number green while the
/// Listening screen and the After card left it black.
///
/// `over` carries two meanings and that is deliberate: "you are over your
/// ceiling" and "this reading is not trustworthy." Both say *the number needs
/// your attention*, and giving the second its own colour would have made the
/// pair a trio for no gain. Failures included — there is no red in this app,
/// because a calibration that did not run is not an emergency either.
///
/// Deliberately not system blue, and deliberately not red: the app is about
/// restraint, and an alarm colour for "you are talking more than you meant to"
/// overstates a thing the user is supposed to notice calmly and adjust.
enum Theme {

    /// Controls, and the state of being inside your intention.
    static let within = adaptive(
        light: UIColor(red: 0.24, green: 0.42, blue: 0.33, alpha: 1),   // moss
        dark:  UIColor(red: 0.50, green: 0.71, blue: 0.58, alpha: 1)
    )

    /// Over the ceiling. Warm, legible, not an alarm.
    static let over = adaptive(
        light: UIColor(red: 0.72, green: 0.42, blue: 0.16, alpha: 1),   // amber
        dark:  UIColor(red: 0.91, green: 0.65, blue: 0.37, alpha: 1)
    )

    /// The one big numeral. Rounded because it is read at a glance and from an
    /// angle, across a desk, by someone who is looking at a person.
    static let numeral = Font.system(size: 72, weight: .thin, design: .rounded)
    static let numeralSmall = Font.system(size: 34, weight: .light, design: .rounded)
    static let counter = Font.system(size: 52, weight: .light, design: .rounded)

    private static func adaptive(light: UIColor, dark: UIColor) -> Color {
        Color(UIColor { traits in
            traits.userInterfaceStyle == .dark ? dark : light
        })
    }
}
