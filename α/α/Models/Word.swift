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
