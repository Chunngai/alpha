//
//  WordOrSentence.swift
//  α
//
//  Created by Sola on 2021/8/23.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

protocol WordOrSentence {
    func equalsTo(_ wordOrSentence: WordOrSentence) -> Bool
}

extension Word: WordOrSentence {
    func equalsTo(_ wordOrSentence: WordOrSentence) -> Bool {
        return self == wordOrSentence as! Word
    }
}

extension Sentence: WordOrSentence {
    func equalsTo(_ wordOrSentence: WordOrSentence) -> Bool {
        return self == wordOrSentence as! Sentence
    }
}

extension Lesson {
    enum ContentType {
        case vocab
        case sentences
    }
    
    func content(of type: ContentType) -> [WordOrSentence]? {
        switch type {
        case .vocab:
            return vocab
        case .sentences:
            return sentences
        }
    }
}
