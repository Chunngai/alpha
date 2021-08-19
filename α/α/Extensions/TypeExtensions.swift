//
//  TypeExtensions.swift
//  α
//
//  Created by Sola on 2021/8/18.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

extension String {
    static let caseAndDiacriticInsensitiveCompareOptions: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
    
    func caseAndDiacriticInsensitivelyContains(_ aString: String) -> Bool {
        return self.range(of: aString, options: String.caseAndDiacriticInsensitiveCompareOptions) != nil
    }
    
    func nsrange(of aString: String, options: String.CompareOptions) -> NSRange? {
        let range = self.range(of: aString, options: options, range: nil, locale: nil)
        if let range = range {
            return NSRange(range, in: self)
        } else {
            return nil
        }
    }
    
    func leftIndent(by indent: Int) -> String {
        return String(repeating: " ", count: indent) + self
    }
    
    func indent(leftIndent: Int, rightIndent: Int) -> String {
        return String(repeating: " ", count: leftIndent) + self + String(repeating: " ", count: rightIndent)
    }
}

extension Sequence where Iterator.Element:NSAttributedString {
    func joined(with separator: NSAttributedString, ignoring charactersToIgnore: String = "") -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else if !charactersToIgnore.contains(e.string) {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(with separator: String, ignoring charactersToIgnore: String = "") -> NSAttributedString {
        return joined(with: NSAttributedString(string: separator), ignoring: charactersToIgnore)
    }
}

extension Word {
    static let posAbbr: [String: String] = [
        "verb": "v.",
        "noun": "n.",
        "pronoun": "pron.",
        "adjective": "adj.",
        "adverb": "adv.",
        "preposition": "prep.",
        "conjunction": "conj.",
        "particle": "part."
    ]
    static let posList = Word.posAbbr.keys
    
    var wordMeaningsWithMarks: String {
        var wordMeaningsConstructor = ""
        
        var wordMeaningsItems: [String] = []
        for wordMeaningsItem in meanings {
            var wordMeaningsItemConstructor = ""
            
            var pos = wordMeaningsItem.pos!
            if let abbrPos = Word.posAbbr[wordMeaningsItem.pos!] {
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

extension Sentence {
    func removeAsterisk(string: String) -> String {
        return string.replacingOccurrences(of: "*", with: "")
    }
    
    var greekSentenceQ: String {
        return removeAsterisk(string: greekSentence)
    }
    
    var greekSentenceA: String {
        return removeAsterisk(string: greekSentence)
    }
    
    var englishSentenceQ: String {
        return removeAsterisk(string: englishSentence)
    }
    
    var englishSentenceA: String {
        return removeAsterisk(string: englishSentence)
            .replacingOccurrences(of: " (sg.)", with: "")
            .replacingOccurrences(of: " (pl.)", with: "")
    }
}
