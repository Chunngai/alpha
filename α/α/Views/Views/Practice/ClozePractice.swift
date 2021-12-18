//
//  ClozePractice.swift
//  α
//
//  Created by Sola on 2021/10/9.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class ClozePractice: ChoicePractice {
        
    var originalSentence: String!
    var maskedWord: String!
    var maskedSentence: String {
        originalSentence.replacingOccurrences(of: maskedWord, with: "______")
    }
    
    internal override var question: String {
        return ClozePractice.prompt
            + "\n"
            + maskedSentence
    }
    
    internal override var answer: String {
        return correctAnswer
    }
    
    private lazy var allWordsInSentences: [String] = {
        var allWordsInLesson: [String] = []
        for sentence in lesson.sentences! {
            allWordsInLesson.append(contentsOf: Tokenizer().tokenize(
                string: sentence.greekSentence,
                withSeparatorsKept: false
            ))
        }
        return allWordsInLesson
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateValues(lesson: Lesson, delegate: PracticeViewController) {
        super.updateValues(lesson: lesson, delegate: delegate)
                        
        generatePractice()
        displayPractice()
    }
}

extension ClozePractice {

    // MARK: - Functions

    func generatePractice() {        
        let sentence = lesson.sentences!.randomElement()!
        
        // Makes the question and answer.
        
        originalSentence = sentence.greekSentence
        
        // Tokenization.
        let wordsInOriginalSentence = Tokenizer().tokenize(
            string: originalSentence,
            withSeparatorsKept: false
        )
        maskedWord = wordsInOriginalSentence.randomElement()!
        correctAnswer = maskedWord
        
        // Makes choices.
        
        // The correct choice.
        choices.append(correctAnswer)
        // Another choices.
        choices.append(contentsOf: [correctAnswer, correctAnswer])
        while choices[1] == correctAnswer {
            choices[1] = allWordsInSentences.randomElement()!
        }
        while choices[2] == correctAnswer || choices[2] == choices[1] {
            choices[2] = allWordsInSentences.randomElement()!
        }
        // Shuffles the choices.
        choices.shuffle()
    }

    func displayPractice() {
        let questionAttrString = NSMutableAttributedString(string: question)
        questionAttrString.set(
            attributes: ChoicePractice.questionAttrs,
            for: ClozePractice.prompt
        )
        questionAttrString.set(
            attributes: ChoicePractice.wordInQuestionAttrs,
            for: maskedSentence
        )
        questionAttrString.set(attributes: ChoicePractice.labelAttrs)
        questionLabel.attributedText = questionAttrString

        for (i, choiceButton) in choiceButtons.enumerated() {
            choiceButton.setTitle(choices[i], for: .normal)
        }
    }
}

extension ClozePractice {
    static let prompt = "Fill in the blank: "
}
