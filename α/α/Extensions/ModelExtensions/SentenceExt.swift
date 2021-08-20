//
//  SentenceExtension.swift
//  α
//
//  Created by Sola on 2021/8/19.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

extension Sentence {
    var greekSentence: String {
        if let greek = greek {
            return greek
        } else {
            return "\(greek_!)*"
        }
    }
    
    var englishSentence: String {
        if let english = english {
            return english
        } else {
            return "\(english_!)*"
        }
    }
    
    func removeAsterisk(string: String) -> String {
        return string.replacingOccurrences(of: "*", with: "")
    }
    
    var isGreekTranslated: Bool {
        return greek_ != nil
    }
    
    var isEnglishTranslated: Bool {
        return english_ != nil
    }
}

extension Sentence {
    var elSentWoAsterisk: String {
        removeAsterisk(string: greekSentence)
    }
    
    var enSentWoAsterisk: String {
        removeAsterisk(string: englishSentence)
    }
}

extension Sentence {
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
