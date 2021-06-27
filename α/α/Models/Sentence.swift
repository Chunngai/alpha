//
//  Sentence.swift
//  α
//
//  Created by Sola on 2021/6/28.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

struct Sentence: Codable {
    private var greek: String?
    private var english: String?
    private var greek_: String?
    private var english_: String?
    
    var greekSentence: String {
        if let greek = greek {
            return greek
        } else {
            return "\(greek_!)*"
        }
    }
    
    var englishSentence: String {
        if let english = english {
            return english
        } else {
            return "\(english_!)*"
        }
    }
}
