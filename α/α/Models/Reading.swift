//
//  File.swift
//  α
//
//  Created by Sola on 2021/6/30.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

struct Reading: Codable {
    var title: String!
    var text: String!
    var vocab: [WordItem]!
    var translation: String!
}

struct WordItem: Codable {
    var word: String!
    var explanation: String!
}
