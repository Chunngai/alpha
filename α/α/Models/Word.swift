//
//  Word.swift
//  α
//
//  Created by Sola on 2021/6/28.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

struct Word: Codable {
    private var stem: String!
    private var prefix: String?
    private var suffix: String?
    private var meanings: [Meanings]!
    var explanation: String?
    
    var word: String {
        var word = ""
        if let prefix = prefix {
            word = "\(prefix)·"
        }
        word += stem
        if let suffix = suffix {
            word += "·\(suffix)"
        }
        return word
    }
    
    var wordMeanings: String {
        var wordMeanings = ""
        for (i, wordMeaningsItem) in meanings.enumerated() {
            var stringBuffer = ""
            
            stringBuffer = "[\(wordMeaningsItem.pos!)]\n"
            stringBuffer += "\(wordMeaningsItem.meanings!)."
            if let usage = wordMeaningsItem.usage {
                stringBuffer += " \(usage)."
            }
            
            if i != meanings.count - 1 {
                stringBuffer += "\n\n"
            }
            
            wordMeanings += "\(stringBuffer)"
        }
        
        return wordMeanings
    }
}

struct Meanings: Codable {
    var pos: String!
    var meanings: String!
    var usage: String?
}
