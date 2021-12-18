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
    private var wordEntrySep: String {
        return ", "
    }
    private var prefixSuffixSep: String {
        return "·"
    }
    
    var wordEntry: String {
        return forms.compactMap {
            wordEntry(of: $0)
        }.joined(separator: wordEntrySep)
    }
    
    private func wordEntry(of form: Form) -> String {
        func articleSequence() -> String {
            if let articles = form.articles {
                return articles.joined(separator: wordEntrySep) + " "
            } else {
                return ""
            }
        }
        
        func prefixSequence() -> String {
            if let prefices = form.prefices {
                return prefices.joined(separator: prefixSuffixSep + wordEntrySep) + prefixSuffixSep
            } else {
                return ""
            }
        }
        
        func suffixSequence() -> String {
            if let suffices = form.suffices {
                return prefixSuffixSep + suffices.joined(separator: wordEntrySep + prefixSuffixSep)
            } else {
                return ""
            }
        }
        
        return articleSequence() + prefixSequence() + form.stem + suffixSequence()
    }
}
 
extension Word {
    var wordMeanings: String {
        return meanings.compactMap {
            var meaningsItem = ""
            
            if let pos = $0.pos {
                meaningsItem = meaningsItem
                    .appending(AttributeToken.makeToken(from: Word.posAbbrs[pos]!))
                    .appending(" ")
            }
            
            if let labels = $0.labels {
                for label in labels {
                    meaningsItem = meaningsItem
                        .appending(AttributeToken.makeToken(from: label))
                        .appending(" ")
                }
            }
            
            if let usage = $0.usage {
                for usageItem in usage {
                    meaningsItem = meaningsItem
                        .appending(AttributeToken.makeToken(from: usageItem))
                        .appending(" ")
                }
            }
            
            meaningsItem = meaningsItem
                .appending($0.meanings!)
                .appending(".")
            
            return meaningsItem
        }.joined(separator: "\n")
    }
}

extension Word {
    var briefContent: String {
        var posList: [String] = []
        var labelList: [String] = []
        var usageList: [String] = []
        
        for item in meanings {
            if let pos = item.pos {
                if !posList.contains(pos) {
                    posList.append(pos)
                }
            }
            if let labels = item.labels {
                for label in labels {
                    if !labelList.contains(label) {
                        labelList.append(label)
                    }
                }
            }
            if let usage = item.usage {
                for usageItem in usage {
                    if !usageList.contains(usageItem) {
                        usageList.append(usageItem)
                    }
                }
            }
        }
        
        var text = ""
        for pos in posList.sorted() {
            text.append(AttributeToken.makeToken(from: Word.posAbbrs[pos]!))
            text.append(" ")
        }
        for label in labelList.sorted() {
            text.append(AttributeToken.makeToken(from: label))
            text.append(" ")
        }
        for usageItem in usageList.sorted() {
            text.append(AttributeToken.makeToken(from: usageItem))
            text.append(" ")
        }
        text.append(wordEntry)
        return text
    }
    
    var detailedContent: String {
        return wordEntry.appending("\n")
            .appending(wordMeanings)
    }
    
    var content: String {
        return wordEntry.appending("\n")
            .appending(wordMeanings).appending("\n")
            .appending(explanation ?? "")
    }
}

extension Word {
    var elEntry: String {
        return wordEntry
    }
    
    var enEntry: String {
        return meanings.compactMap { (meanings) -> String in
            meanings.meanings
        }.joined(separator: "; ")
    }
}

extension Word {
    var wordSentences: String? {
        guard let sentences = sentences else {
            return nil
        }
        
        return sentences.compactMap {
            "• " + $0
        }.joined(separator: "\n")
    }
}

extension Word {
    static let posAbbrs: [String: String] = [
        "verb": "v.",
        "noun": "n.",
        "pronoun": "pron.",
        "adjective": "adj.",
        "adverb": "adv.",
        "preposition": "prep.",
        "conjunction": "conj.",
        "particle": "part.",
    ]
}
