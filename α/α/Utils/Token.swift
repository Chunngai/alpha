//
//  Token.swift
//  α
//
//  Created by Sola on 2021/8/22.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

struct Token {
    static func makeToken(from string: String) -> String {
        return string.indent(leftIndent: 1, rightIndent: 1)
    }
    
    static func highlightTokens(
        in textView: RoundCornersBgTextView,
        with font: UIFont = Theme.bodyFont
    ) {
        for (string, color) in Token.mapping {
            textView.setRoundCornersBackground(
                forAll: Token.makeToken(from: string),
                withColor: color,
                withFont: font
            )
        }
    }
}

extension Token {
    static var mapping: [String: UIColor] {
        return [
            // Pos.
            
            "v.": Theme.verbColor,
            "n.": Theme.nounColor,
            "pron.": Theme.pronounColor,
            "adj.": Theme.adjectiveColor,
            "adv.": Theme.adverbColor,
            "prep.": Theme.prepositionColor,
            "conj.": Theme.conjunctionColor,
            "part.": Theme.particleColor,
            
            // Labels.
            
            // Verb attrs.
            "mid.": Theme.defaultTokenColor,  // Specific meanings for middle voice.
            "dep.": Theme.defaultTokenColor,  // Deponents.
            
            // Noun attrs.
            "sub.": Theme.defaultTokenColor,
            
            // Adverb attrs.
            "neg.": Theme.defaultTokenColor,  // Negative.
            
            "ind.": Theme.defaultTokenColor,  // Indicative.
            "imp.": Theme.defaultTokenColor,  // Imperative.
            
            "proc.": Theme.defaultTokenColor,  // Proclotic.
            
            "cor.": Theme.defaultTokenColor,  // Correlative.
            
            // Adjective attrs.
            "m/n.": Theme.defaultTokenColor,  // Masculine & neuter forms only.
            
            // Conjunction & particle attrs.
            "post.": Theme.defaultTokenColor,  // Postpositive.
            
            // Others.
            "dem.": Theme.defaultTokenColor,  // Demonstrative.
            
            // Usage.
        ]
    }
}
