//
//  WordOrSentenceContainer.swift
//  α
//
//  Created by Sola on 2021/8/23.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

class ContentContainer {
    var contentTypeHavingInterestIn: Lesson.ContentType!

    var havingInterestInVocab: Bool {
        return contentTypeHavingInterestIn == .vocab
    }
    var havingInterestInSentences: Bool {
        return contentTypeHavingInterestIn == .sentences
    }
}

class LessonContainer: ContentContainer {
    var lessons: [Lesson] = []
    
    init(vocab: [Lesson]? = nil, sentences: [Lesson]? = nil) {
        super.init()
        
        if let vocab = vocab {
            self.lessons = vocab
            contentTypeHavingInterestIn = .vocab
        } else if let sentences = sentences {
            self.lessons = sentences
            contentTypeHavingInterestIn = .sentences
        }
    }
}

class WordOrSentenceContainer: ContentContainer {
    var vocabOrSentences: [WordOrSentence] = []
    
    init(vocabOrSentences: [WordOrSentence], contentType: Lesson.ContentType) {
        super.init()
        
        self.vocabOrSentences = vocabOrSentences
        self.contentTypeHavingInterestIn = contentType
    }
    
    func firstIndex(of wordOrSentence: WordOrSentence) -> Int? {
        return vocabOrSentences.firstIndex {
            $0.equalsTo(wordOrSentence)
        }
    }
}
