//
//  Word.swift
//  α
//
//  Created by Sola on 2021/6/28.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

struct Word: Codable, Equatable {
    
    struct Form: Codable, Equatable {
        var stem: String!
        var prefices: [String]?
        var suffices: [String]?
        var articles: [String]?
    }
    
    struct Meanings: Codable, Equatable {
        var pos: String!
        var meanings: String!
        var usage: String?
    }
    
    var forms: [Form]!
    var meanings: [Meanings]!
    var explanation: String?
}

extension Word.Form {
    // MARK: - Equatable
    
    static func == (lhs: Word.Form, rhs: Word.Form) -> Bool {
        return lhs.stem == rhs.stem
            && lhs.prefices == rhs.prefices
            && lhs.suffices == rhs.suffices
            && lhs.articles == rhs.articles
    }
}

extension Word.Meanings {
    // MARK: - Equatable
    
    static func == (lhs: Word.Meanings, rhs: Word.Meanings) -> Bool {
        return lhs.pos == rhs.pos
            && lhs.meanings == rhs.meanings
            && lhs.usage == rhs.usage
    }
}

extension Word {
    // MARK: - Equatable
    
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.forms == rhs.forms
            && lhs.meanings == rhs.meanings
            && lhs.explanation == rhs.explanation
    }
}
