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
        return greek ?? greek_!
    }
    
    var englishSentence: String {
        return english ?? english_!
    }
}

extension Sentence {
    static var greekLangToken = Token.makeToken(from: "el ")
    static var englishLangToken = Token.makeToken(from: "en")
    
    var isEnglishTranslated: Bool {
        return english_ != nil
    }
    
    var textLangToken: String {
        return isEnglishTranslated ? Sentence.greekLangToken : Sentence.englishLangToken
    }
    
    var text: String {
        return isEnglishTranslated ? greekSentence : englishSentence
    }
    
    var translationLangToken: String {
        return isEnglishTranslated ? Sentence.englishLangToken : Sentence.greekLangToken
    }
    
    var translation: String {
        return isEnglishTranslated ? englishSentence : greekSentence
    }
    
    var briefContent: String {
        return textLangToken.appending(" ")
            .appending(text)
    }
    
    var content: String {
        return textLangToken.appending(" ")
            .appending(text).appending("\n")
            .appending(translationLangToken).appending(" ")
            .appending(translation)
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
