//
//  WordExtension.swift
//  α
//
//  Created by Sola on 2021/8/19.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

extension Word {
    static let posAbbrs: [String: String] = [
        "verb": "v.",
        "noun": "n.",
        "pronoun": "pron.",
        "adjective": "adj.",
        "adverb": "adv.",
        "preposition": "prep.",
        "conjunction": "conj.",
        "particle": "part."
    ]
    static let posColors: [String: UIColor] = [
        "verb": Theme.verbColor,
        "noun": Theme.nounColor,
        "pronoun": Theme.pronounColor,
        "adjective": Theme.adjectiveColor,
        "adverb": Theme.adverbColor,
        "preposition": Theme.prepositionColor,
        "conjunction": Theme.conjunctionColor,
        "particle": Theme.particleColor
    ]
    
    static let posList = Word.posAbbrs.keys
}

extension Word {
    var wordEntry: String {
        var wordEntryConstructor = ""
        
        var wordEntriesOfEachForm: [String] = []
        for form in forms {
            let wordEntryOfForm = getWordEntry(of: form)
            wordEntriesOfEachForm.append(wordEntryOfForm)
        }
        wordEntryConstructor.append(wordEntriesOfEachForm.joined(separator: ", "))
        
        return wordEntryConstructor
    }
    
    func getWordEntry(of form: Form) -> String {
        func articleSequence(of form: Form, with articles: [String]) -> String {
            return articles.joined(separator: ", ") + " "
        }
        
        func prefixSequence(of form: Form, with prefices: [String]) -> String {
            return prefices.joined(separator: "·, ") + "·"
        }
        
        func suffixSequence(of form: Form, with suffices: [String]) -> String {
            return "·" + suffices.joined(separator: ", ·")
        }
        
        var wordEntryOfForm = ""
        
        if let articles = form.articles {
            wordEntryOfForm += articleSequence(of: form, with: articles)
        }
        
        wordEntryOfForm += form.stem
        
        if let prefices = form.prefices {
            wordEntryOfForm += prefixSequence(of: form, with: prefices)
        }
        
        if let suffices = form.suffices {
            wordEntryOfForm += suffixSequence(of: form, with: suffices)
        }
        
        return wordEntryOfForm
    }
}
 
extension Word {
    var wordMeanings: String {
        var wordMeaningsConstructor = ""
        
        var wordMeaningsItems: [String] = []
        for wordMeaningsItem in meanings {
            var wordMeaningsItemConstructor = ""
            
            var pos = wordMeaningsItem.pos!
            if let abbrPos = Word.posAbbrs[wordMeaningsItem.pos!] {
                pos = abbrPos
            }
            wordMeaningsItemConstructor = " \(pos) "
            wordMeaningsItemConstructor += " "
            wordMeaningsItemConstructor.append("\(wordMeaningsItem.meanings!).")
            if let usage = wordMeaningsItem.usage {
                wordMeaningsItemConstructor.append("\n☆ \(usage)")
            }
            
            wordMeaningsItems.append(wordMeaningsItemConstructor)
        }
        wordMeaningsConstructor = wordMeaningsItems.joined(separator: "\n")
        
        return wordMeaningsConstructor
    }
}
