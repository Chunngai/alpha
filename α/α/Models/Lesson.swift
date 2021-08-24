//
//  Lesson.swift
//  α
//
//  Created by Sola on 2021/1/16.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

struct Lesson: Codable {
    var id: Int!
    var title: String!
    var vocab: [Word]?
    var sentences: [Sentence]?
    var reading: Reading?
    
    var pdfName: String {
        return "lesson\(id!)"
    }
}

struct TextBook: Codable {
    // MARK: IO
    
    static func loadLesson(id: Int) -> Lesson? {
        guard let lessonPath = Bundle.main.path(forResource: "lesson\(id)", ofType: ".json") else { return nil }
        let lessonData = NSData.init(contentsOfFile: lessonPath)! as Data
        do {
            let lesson = try JSONDecoder().decode(Lesson.self, from: lessonData)
            return lesson
        } catch {
            return nil
        }
    }
    
    static func loadLessons() -> [Lesson] {
        var lessons: [Lesson] = []
        for id in 1...50 {
            if let lesson = loadLesson(id: id) {
                lessons.append(lesson)
            }
        }
//        TextBook.collectSentencesForWords(from: &lessons)
        return lessons
    }
}

//extension TextBook {
//    static func collectSentencesAndTokens(from lessons: [Lesson]) -> [String: [String]] {
//        var greekSentencesAndTokens: [String: [String]] = [:]
//
//        let tokenizer = Tokenizer()
//        for lesson in lessons {
//            guard let sentences = lesson.sentences else {
//                continue
//            }
//            for sentence in sentences {
//                guard let greekSentence = sentence.greek else {
//                    break
//                }
//                greekSentencesAndTokens[greekSentence] = tokenizer.tokenize(string: greekSentence, withSeparatorsKept: false)
//            }
//        }
//        return greekSentencesAndTokens
//    }
//
//    static func collectSentences(for word: Word, from greekSentencesAndTokens: [String: [String]]) -> [String]? {
//        var sentencesForWord: [String] = []
//
//        let wordStems = word.forms.compactMap {
//            return $0.stem.components(separatedBy: " (")[0]
//        }
//        for (greekSentence, sentenceTokens) in greekSentencesAndTokens {
//            secondFor: for wordStem in wordStems {
//                for sentenceToken in sentenceTokens {
//                    if sentenceToken.caseAndDiacriticInsensitivelyContains(wordStem) {
//                        sentencesForWord.append(greekSentence)
//                        break secondFor
//                    }
//                }
//            }
//        }
//        if sentencesForWord.count > 0 {
//            return sentencesForWord
//        } else {
//            return nil
//        }
//    }
//
//    static func collectSentencesForWords(from lessons: inout [Lesson]) {
//        let greekSentencesAndTokens: [String: [String]] = TextBook.collectSentencesAndTokens(from: lessons)
//        for (lessonId, lesson) in lessons.enumerated() {
//            guard let vocab = lesson.vocab else {
//                continue
//            }
//
//            for (i, word) in vocab.enumerated() {
//                lessons[lessonId].vocab![i].sentences = collectSentences(for: word, from: greekSentencesAndTokens)
//            }
//        }
//    }
//}
