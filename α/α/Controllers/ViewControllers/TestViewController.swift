//
//  TestViewController.swift
//  α
//
//  Created by Sola on 2021/6/28.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UITextFieldDelegate {

    var currentTestItemIndex: Int = -1 {
        didSet {
            if currentTestItemIndex == -1 {
                currentTestItemIndex = testItems.count - 1
            }
            if currentTestItemIndex == testItems.count {
                currentTestItemIndex = 0
            }
        }
    }
    var testItems: [[String: String]] = []
    
    var isCommitted: Bool = false
        
    // MARK: - Views
    
    lazy var mainView: UIView = {
        let mainView = UIView()
        view.addSubview(mainView)
        
        mainView.addGestureRecognizer({
            var swipeGestureRecognizer = UISwipeGestureRecognizer()
            swipeGestureRecognizer.direction = .right
            swipeGestureRecognizer.addTarget(self, action: #selector(mainViewRightSwiped))
            return swipeGestureRecognizer
        }())
        mainView.addGestureRecognizer({
            var swipeGestureRecognizer = UISwipeGestureRecognizer()
            swipeGestureRecognizer.direction = .left
            swipeGestureRecognizer.addTarget(self, action: #selector(mainViewLeftSwiped))
            return swipeGestureRecognizer
        }())
        mainView.addGestureRecognizer({
            var tapGestureRecognizer = UITapGestureRecognizer()
            tapGestureRecognizer.addTarget(self, action: #selector(mainViewTapped))
            return tapGestureRecognizer
        }())
        
        mainView.backgroundColor = .lightBlue
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        
        return mainView
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        self.mainView.addSubview(label)
        
        label.addGestureRecognizer({
            let doubleTappedGestureRecognizer = UITapGestureRecognizer()
            doubleTappedGestureRecognizer.numberOfTapsRequired = 2
            doubleTappedGestureRecognizer.addTarget(self, action: #selector(questionLabelDoubleTapped))
            return doubleTappedGestureRecognizer
        }())
        
        label.backgroundColor = self.mainView.backgroundColor
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    lazy var answerTextField: UnderLineTextField = {
        let textField = UnderLineTextField()
        self.mainView.addSubview(textField)
        
        textField.delegate = self
        textField.backgroundColor = self.mainView.backgroundColor
        textField.textColor = .black
        textField.textAlignment = .center
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 23)
        
        return textField
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        
        nextTest()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func updateViews() {
        view.backgroundColor = .white
        
        mainView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.80)
            make.width.equalToSuperview().multipliedBy(0.90)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
        }
        
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mainView.snp.top).offset(200)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalToSuperview().multipliedBy(0.85)
        }
        
        answerTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(questionLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalToSuperview().multipliedBy(0.80)
        }
    }
    
    func updateValues(sentences: [Sentence]) {
        for sentence in sentences {
            var greek2EnglishTestItem: [String: String] = [:]
            greek2EnglishTestItem["Q"] = sentence.greekSentenceQ
            greek2EnglishTestItem["A"] = sentence.englishSentenceA
            testItems.append(greek2EnglishTestItem)
        }
        
        for sentence in sentences {
            var english2GreekTestItem: [String: String] = [:]
            english2GreekTestItem["Q"] = sentence.englishSentenceQ
            english2GreekTestItem["A"] = sentence.greekSentenceA
            testItems.append(english2GreekTestItem)
        }
    }
    
    // MARK: - Actions
    
    @objc func mainViewRightSwiped() {
        previousTest()
    }
    
    @objc func mainViewLeftSwiped() {
        nextTest()
    }
    
    @objc func mainViewTapped() {
        answerTextField.endEditing(true)
    }
    
    @objc func questionLabelDoubleTapped() {
        if isCommitted {
            if questionLabel.text == testItems[currentTestItemIndex]["Q"] {
                questionLabel.text = testItems[currentTestItemIndex]["A"]
            } else {
                questionLabel.text = testItems[currentTestItemIndex]["Q"]
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= (keyboardFrame.minY - answerTextField.frame.maxY)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    // MARK: - Utils
    
    func update() {
        questionLabel.text = testItems[currentTestItemIndex]["Q"]
        answerTextField.text = ""
        
        isCommitted = false
    }
    
    func previousTest() {
        currentTestItemIndex -= 1
        update()
    }
    
    func nextTest() {
        currentTestItemIndex += 1
        update()
    }
}

extension TestViewController {
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkInputAnswer()
        isCommitted = true
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}

extension TestViewController {
    // MARK: - Text Processing
    
    static let punctuations = ",.·;?!"
    
    func tokenize(string: String) -> [String] {
        var tokens: [String] = []
        
        for tokenSeparatedBySpace in string.components(separatedBy: " ") {
            var tokenBuffer: String = ""
            for characterOfTokenSeparatedBySpace in tokenSeparatedBySpace {
                if !TestViewController.punctuations.contains(characterOfTokenSeparatedBySpace) {
                    tokenBuffer += String(characterOfTokenSeparatedBySpace)
                    continue
                }
                
                if tokenBuffer != "" {
                    tokens.append(tokenBuffer)
                    tokenBuffer = ""
                }
                
                tokens.append(String(characterOfTokenSeparatedBySpace))
            }
            if tokenBuffer != "" {
                tokens.append(tokenBuffer)
                tokenBuffer = ""
            }
        }
        return tokens
    }
    
    func checkInputAnswer() {
        guard let inputAnswer = answerTextField.text else { return }
        
        let goldAnswerTokens = tokenize(string: testItems[currentTestItemIndex]["A"]!)
        var inputAnswerTokens = tokenize(string: inputAnswer.replacingOccurrences(of: "’", with: "\'"))
        
        var matchedTokens: [NSMutableAttributedString] = []
        for token in goldAnswerTokens {
            let attributedToken = NSMutableAttributedString(string: token)
            
            if !inputAnswerTokens.contains(token) {
                matchedTokens.append(attributedToken)
                continue
            }
            
            inputAnswerTokens.remove(at: inputAnswerTokens.firstIndex(of: token)!)
    
            attributedToken.setHightlight(color: .green)
            matchedTokens.append(attributedToken)
        }
        questionLabel.attributedText = matchedTokens.joined(
            with: " ",
            ignoring: TestViewController.punctuations
        )
    }
}

extension Sentence {
    func removeAsterisk(string: String) -> String {
        return string.replacingOccurrences(of: "*", with: "")
    }
    
    var greekSentenceQ: String {
        return removeAsterisk(string: greekSentence)
    }
    
    var greekSentenceA: String {
        return removeAsterisk(string: greekSentence)
    }
    
    var englishSentenceQ: String {
        return removeAsterisk(string: englishSentence)
    }
    
    var englishSentenceA: String {
        return removeAsterisk(string: englishSentence)
            .replacingOccurrences(of: " (sg.)", with: "")
            .replacingOccurrences(of: " (pl.)", with: "")
    }
}

extension Sequence where Iterator.Element:NSAttributedString {
    func joined(with separator: NSAttributedString, ignoring charactersToIgnore: String = "") -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else if !charactersToIgnore.contains(e.string) {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(with separator: String, ignoring charactersToIgnore: String = "") -> NSAttributedString {
        return joined(with: NSAttributedString(string: separator), ignoring: charactersToIgnore)
    }
}
