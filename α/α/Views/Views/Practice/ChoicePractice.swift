//
//  ChoicePractice.swift
//  α
//
//  Created by Sola on 2021/10/9.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class ChoicePractice: UIView, Practice {
            
    var choices: [String] = []
    
    var chosenAnswer: String!
    var correctAnswer: String!
    
    internal var question: String {
        return ""
    }
    
    internal var answer: String {
        return ""
    }
    
    internal func check() -> Float {
        return chosenAnswer == correctAnswer
            ? 1
            : 0
    }
    
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
    
    lazy var choiceButtons: [UIButton] = {
        var buttons: [UIButton] = []
        for i in [1, 2, 3] {
            let button = UIButton()
            
            button.setTitleColor(.darkGray, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = Theme.bodyFont
            button.backgroundColor = Theme.lightBlue3
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.titleLabel?.lineBreakMode = .byTruncatingTail
            button.tag = i
            button.titleEdgeInsets = UIEdgeInsets(
                top: 10,
                left: 10,
                bottom: 10,
                right: 10
            )
            button.titleLabel?.numberOfLines = 0
            
            buttons.append(button)
        }
        return buttons
    }()
    
    lazy var choicesStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: choiceButtons)
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateViews()
        updateLayouts()
        
        for button in choiceButtons {
            button.addTarget(
                self,
                action: #selector(choiceButtonTapped(_:)),
                for: .touchUpInside
            )
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateViews() {
        addSubview(questionLabel)
        addSubview(choicesStack)
    }
    
    func updateLayouts() {
        questionLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
        }
        
        choicesStack.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        for choiceButton in choiceButtons {
            choiceButton.snp.makeConstraints { (make) in
                make.width.equalToSuperview()
                make.height.greaterThanOrEqualTo(50)
            }
        }
    }
    
    func updateValues(lesson: Lesson, delegate: PracticeViewController) {
        self.lesson = lesson
        self.delegate = delegate
    }
}

extension ChoicePractice {
    
    func deselectOtherChoices() {
        for choiceButton in choiceButtons {
            choiceButton.backgroundColor = Theme.lightBlue3
        }
    }
    
    // MARK: - Actions
    
    @objc func choiceButtonTapped(_ sender: UIButton) {
        guard delegate.isEditable else { return }
        
        delegate.activateCheckButton()
        deselectOtherChoices()
        
        let chosenButton = choiceButtons[sender.tag - 1]
        chosenButton.backgroundColor = Theme.lightBlue2
        chosenAnswer = chosenButton.titleLabel?.text
    }
}

extension ChoicePractice {
    static let questionAttrs: [NSAttributedString.Key: Any] = [
        .font : UIFont(
            name: "Arial Rounded MT Bold",
            size: Theme.title2Font.pointSize
        )!
    ]
    static let wordInQuestionAttrs: [NSAttributedString.Key: Any] = [
        .font : UIFont.systemFont(
            ofSize: Theme.bodyFont.pointSize,
            weight: .regular
        )
    ]
    static let labelAttrs: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.paragraphStyle : Theme.paraStyle1
    ]
}
