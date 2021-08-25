//
//  Token.swift
//  α
//
//  Created by Sola on 2021/8/22.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

struct AttributeToken {
    static func makeToken(from string: String) -> String {
        return string.indent(leftIndent: 1, rightIndent: 1)
    }
    
    static func highlightAttributeTokens(
        in textView: RoundCornersBgTextView,
        with font: UIFont = Theme.bodyFont
    ) {
        for (string, color) in AttributeToken.mapping {
            textView.setRoundCornersBackground(
                forAll: AttributeToken.makeToken(from: string),
                withColor: color,
                withFont: font
            )
        }
    }
}

extension AttributeToken {
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
            
            "expr.": Theme.defaultTokenColor,  // Expression.
            
            "interj.": Theme.defaultTokenColor,  // Interjection.
                        
            "proc.": Theme.defaultTokenColor,  // Proclotic.
            "enc.": Theme.defaultTokenColor,  // Enclitic.
            
            // Verb attrs.
            "mid.": Theme.verbColor,  // Specific meanings for middle voice.
            "dep.": Theme.verbColor,  // Deponents.
            "·ησω": Theme.verbColor,  // Future stem ending with ησω.
            
            // Noun attrs.
            "·α": Theme.nounColor,  // 1st declension: short alpha.
            "·η|·ᾱς": Theme.nounColor,  // 1st declension: m. nouns.
            "ἡ·ος": Theme.nounColor,  // Fem. noun ending with ος
            "epi.": Theme.nounColor,  // Epicene.
            
            // Adjective attrs.
            "sub.": Theme.adjectiveColor,  // Substantive.
            "2end.": Theme.adjectiveColor,  // Masculine & neuter forms only.
            
            // Pronouns & adjective attrs.
            "dem.": UIColor.mix(Theme.pronounColor, with: Theme.adjectiveColor),  // Demonstrative.
            
            // Adverb attrs.            
            "ind.": Theme.adverbColor,  // Indicative.
            "imp.": Theme.adverbColor,  // Imperative.
            
            // Conjunction & particle attrs.
            "post.": UIColor.mix(Theme.conjunctionColor, with: Theme.particleColor),  // Postpositive.
            "cor.": UIColor.mix(Theme.conjunctionColor, with: Theme.particleColor),  // Correlatives.
                        
            // Usage.
            
            "nom.": Theme.lightBlue,
            "gen.": Theme.lightBlue,
            "dat.": Theme.lightBlue,
            "acc.": Theme.lightBlue,
            "voc.": Theme.lightBlue,
            
            "inf.": Theme.lightBlue,
            "fut.inf.": Theme.lightBlue,
            "pres.inf.": Theme.lightBlue
        ]
    }
}
