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
            return "\(greek_!)"
        }
    }
    
    var englishSentence: String {
        if let english = english {
            return english
        } else {
            return "\(english_!)"
        }
    }
    
    var isGreekTranslated: Bool {
        return greek_ != nil
    }
    
    var isEnglishTranslated: Bool {
        return english_ != nil
    }
}

extension Sentence {
    var greekSentenceQ: String {
        return greekSentence
    }
    
    var greekSentenceA: String {
        return greekSentence
    }
    
    var englishSentenceQ: String {
        return englishSentence
    }
    
    var englishSentenceA: String {
        return englishSentence
            .replacingOccurrences(of: " (sg.)", with: "")
            .replacingOccurrences(of: " (pl.)", with: "")
    }
}
