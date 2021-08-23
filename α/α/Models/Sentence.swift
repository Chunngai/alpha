//
//  Sentence.swift
//  α
//
//  Created by Sola on 2021/6/28.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

struct Sentence: Codable {
    var greek: String?
    var english: String?
    var greek_: String?
    var english_: String?
}

extension Sentence: Equatable {
    // MARK: - Equatable
    
    static func == (lhs: Sentence, rhs: Sentence) -> Bool {
        return lhs.greek == rhs.greek
            && lhs.english == rhs.english
            && lhs.greek_ == rhs.greek_
            && lhs.english_ == rhs.english_
    }
}
