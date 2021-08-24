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
        var labels: [String]?
        var usage: String?  // TODO: - change here.
    }
    
    var forms: [Form]!
    var meanings: [Meanings]!
    var explanation: String?
    // Sentences containing the word.
    var sentences: [String]?
}

extension Word.Form: Equatable {
    // MARK: - Equatable
    
    static func == (lhs: Word.Form, rhs: Word.Form) -> Bool {
        return lhs.stem == rhs.stem
            && lhs.prefices == rhs.prefices
            && lhs.suffices == rhs.suffices
            && lhs.articles == rhs.articles
    }
}

extension Word.Meanings: Equatable {
    // MARK: - Equatable
    
    static func == (lhs: Word.Meanings, rhs: Word.Meanings) -> Bool {
        return lhs.pos == rhs.pos
            && lhs.meanings == rhs.meanings
            && lhs.labels == rhs.labels
            && lhs.usage == rhs.usage
    }
}

extension Word: Equatable {
    // MARK: - Equatable
    
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.forms == rhs.forms
            && lhs.meanings == rhs.meanings
            && lhs.explanation == rhs.explanation
        
            && lhs.sentences == rhs.sentences
    }
}
