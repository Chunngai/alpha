//
//  Word.swift
//  α
//
//  Created by Sola on 2021/6/28.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

struct Word: Codable {
    
    struct Form: Codable {
        var stem: String!
        var prefices: [String]?
        var suffices: [String]?
        var articles: [String]?
    }
    
    struct Meanings: Codable {
        var pos: String!
        var meanings: String!
        var usage: String?
    }
    
    private var forms: [Form]!
    private var meanings: [Meanings]!
    var explanation: String?
    
    var wordEntry: String {
        var wordEntry = ""
        
        for (i, form) in forms.enumerated() {
            let wordEntryOfForm = getWordEntry(of: form)
            wordEntry += wordEntryOfForm
            if i != forms.count - 1 {
                wordEntry += ", "
            }
        }
        
        return wordEntry
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
    
    func articleSequence(of form: Form, with articles: [String]) -> String {
        return articles.joined(separator: ", ") + " "
    }
    
    func prefixSequence(of form: Form, with prefices: [String]) -> String {
        return prefices.joined(separator: "·, ") + "·"
    }
    
    func suffixSequence(of form: Form, with suffices: [String]) -> String {
        return "·" + suffices.joined(separator: ", ·")
    }
    
    func getWordEntry(of form: Form) -> String {
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
