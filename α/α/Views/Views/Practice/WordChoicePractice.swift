//
//  WordChoicePractice.swift
//  α
//
//  Created by Sola on 2021/10/8.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class WordChoicePractice: ChoicePractice {
            
    var practiceType: WordChoicePractice.PracticeType!
    
    var wordInQuestion: String!
    
    internal override var question: String {
        return WordChoicePractice.prompt + "\n" + wordInQuestion
    }
    
    internal override var answer: String {
        return correctAnswer
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateValues(lesson: Lesson, practiceType: WordChoicePractice.PracticeType, delegate: PracticeViewController) {
        super.updateValues(lesson: lesson, delegate: delegate)
                
        self.practiceType = practiceType
        
        generatePractice()
        displayPractice()
    }
}

extension WordChoicePractice {
    
    enum PracticeType {
        case el2en
        case en2el
    }
}

extension WordChoicePractice {
    
    // MARK: - Functions
    
    func generatePractice() {
        let word = lesson.vocab!.randomElement()!
        
        // Makes the question and answer.
        if practiceType == .el2en {
            wordInQuestion = word.elEntry
            correctAnswer = word.enEntry
        } else {
            wordInQuestion = word.enEntry
            correctAnswer = word.elEntry
        }
        
        // Makes choices.
        
        // The correct choice.
        choices.append(correctAnswer)
        // Another choices.
        var anotherWords: [Word] = [word, word]
        while anotherWords[0] == word {
            anotherWords[0] = lesson.vocab!.randomElement()!
        }
        while anotherWords[1] == word || anotherWords[1] == anotherWords[0] {
            anotherWords[1] = lesson.vocab!.randomElement()!
        }
        choices.append(
            practiceType == .el2en
                ? anotherWords[0].enEntry
                : anotherWords[0].elEntry
        )
        choices.append(
            practiceType == .el2en
                ? anotherWords[1].enEntry
                : anotherWords[1].elEntry
        )
        // Shuffles the choices.
        choices.shuffle()
    }
    
    func displayPractice() {
        let questionAttrString = NSMutableAttributedString(string: question)
        questionAttrString.set(
            attributes: WordChoicePractice.questionAttrs,
            for: WordChoicePractice.prompt
        )
        questionAttrString.set(
            attributes: WordChoicePractice.wordInQuestionAttrs,
            for: wordInQuestion
        )
        questionAttrString.set(attributes: WordChoicePractice.labelAttrs)
        questionLabel.attributedText = questionAttrString
        
        for (i, choiceButton) in choiceButtons.enumerated() {
            choiceButton.setTitle(choices[i], for: .normal)
        }
    }
}

extension WordChoicePractice {
    static let prompt = "How do you say:"
}
