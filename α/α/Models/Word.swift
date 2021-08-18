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
    
    var forms: [Form]!
    var meanings: [Meanings]!
    var explanation: String?
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
    
    var wordMeanings: String {
        var wordMeaningsConstructor = ""
        
        var wordMeaningsItems: [String] = []
        for wordMeaningsItem in meanings {
            var wordMeaningsItemConstructor = ""
            
            wordMeaningsItemConstructor = "[\(wordMeaningsItem.pos!)] "
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

extension Word {
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
