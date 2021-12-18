//
//  TranslationPractice.swift
//  α
//
//  Created by Sola on 2021/10/9.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TranslationPractice: UIView, Practice {
    
    var question: String {
        return TranslationPractice.prompt + "\n" + sentenceToTranslate
    }
    
    var answer: String {
        return sentenceTranslation
            .replacingOccurrences(of: "n't", with: " not").replacingOccurrences(of: "'s", with: " is").replacingOccurrences(of: "'m", with: " am")
            .replacingOccurrences(of: "μ", with: "µ")  // TODO: why?
    }
    
    func check() -> Float {
        let tokenizer = Tokenizer()
        
        let wordsOfInputSentence = Set(tokenizer.tokenize(
            string: inputSentence,
            withSeparatorsKept: false,
            lowercase: true
        ))
        let wordsOfAnswerSentence = Set(tokenizer.tokenize(
            string: answer,
            withSeparatorsKept: false,
            lowercase: true
        ))
        
        let union = wordsOfInputSentence.union(wordsOfAnswerSentence)
        let intersection = wordsOfInputSentence.intersection(wordsOfAnswerSentence)
        
        var similarity = Float(intersection.count) / Float(union.count)
        if similarity == 0 {
            similarity = 1e-6
        }

        return similarity
    }
    
    var inputSentence: String {
        textView.text
            .trimmingWhitespacesAndNewlines()
            .replacingOccurrences(of: "’", with: "'")
            .replacingOccurrences(of: "n't", with: " not").replacingOccurrences(of: "'s", with: " is").replacingOccurrences(of: "'m", with: " am")
            .replacingOccurrences(of: "μ", with: "µ")  // TODO: Why?
    }
    
    var practiceType: TranslationPractice.PracticeType!
    
    var sentenceToTranslate: String!
    var sentenceTranslation: String!
    
    // MARK: - Models
    
    var lesson: Lesson!
    
    // MARK: - Controllers
    
    var delegate: PracticeViewController!
    
    // MARK: - Views
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.layer.cornerRadius = 20
        textView.layer.masksToBounds = true
        textView.backgroundColor = .hexRGB2UIColor("F7F7F7")
        textView.layer.borderColor = UIColor.hexRGB2UIColor("#E5E5E5").cgColor
        textView.layer.borderWidth = 2
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textView.font = Theme.bodyFont
        
        return textView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textView.delegate = self
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        updateViews()
        updateLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateViews() {
        addSubview(questionLabel)
        addSubview(textView)
    }
    
    func updateLayouts() {
        questionLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
        }
        
        textView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(350)
            make.centerX.equalToSuperview()
            make.top.equalTo(questionLabel.snp.bottom).offset(20)
        }
    }
    
    func updateValues(lesson: Lesson, practiceType: TranslationPractice.PracticeType, delegate: PracticeViewController) {
        self.lesson = lesson
        self.practiceType = practiceType
        self.delegate = delegate
        
        generatePractice()
        displayPractice()
    }
}

extension TranslationPractice {
    
    // MARK: - Functions
    
    func generatePractice() {
        let sentence = lesson.sentences!.randomElement()!
        if practiceType == .el2en {
            sentenceToTranslate = sentence.greekSentence
            sentenceTranslation = sentence.englishSentence
        } else {
            sentenceToTranslate = sentence.englishSentence
            sentenceTranslation = sentence.greekSentence
        }
        sentenceTranslation = sentenceTranslation
            .replacingOccurrences(of: " (sg.)", with: "")
            .replacingOccurrences(of: " (pl.)", with: "")
    }
    
    func displayPractice() {
        let questionAttrString = NSMutableAttributedString(string: question)
        questionAttrString.set(
            attributes: WordChoicePractice.questionAttrs,  // TODO: change here.
            for: TranslationPractice.prompt
        )
        questionAttrString.set(
            attributes: WordChoicePractice.wordInQuestionAttrs,  // TODO: change here.
            for: sentenceToTranslate
        )
        questionAttrString.set(attributes: WordChoicePractice.labelAttrs)
        questionLabel.attributedText = questionAttrString
    }
}

extension TranslationPractice {
    enum PracticeType {
        case el2en
        case en2el
    }
    
}

extension TranslationPractice: UITextViewDelegate {
    
    // MARK: - UITextView Delegate
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.trimmingWhitespacesAndNewlines().isEmpty {
            delegate.activateCheckButton()
        } else {
            delegate.inactivateCheckButton()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return delegate.isEditable
    }
}

extension TranslationPractice {
    
    // MARK: - Actions
    
    @objc func viewTapped() {
        textView.resignFirstResponder()
    }
}

extension TranslationPractice {
    static let prompt = "Translate this sentence: "
}
