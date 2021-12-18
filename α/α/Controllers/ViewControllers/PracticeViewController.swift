//
//  PracticeViewController.swift
//  α
//
//  Created by Sola on 2021/10/8.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController {

    var shouldCheck: Bool = true {
        didSet {
            var buttonTitle: String
            if shouldCheck {
                buttonTitle = "CHECK"
                isEditable = true
            } else {
                buttonTitle = "CONTINUE"
                isEditable = false
            }
            button.setTitle(buttonTitle, for: .normal)
        }
    }
    var similarity: Float!

    var isEditable: Bool = true
    
    // MARK: - Models
    
    private var lesson: Lesson!
    
    // MARK: - Views
    
    private var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var button: PracticeButton = {
        let button = PracticeButton()
        button.setTitle("CHECK", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Theme.bodyFont.pointSize)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.inactivate()
        return button
    }()
    
    var currentPractice: Practice! {
        didSet {
            if oldValue != nil {
                oldValue.removeFromSuperview()
            }
            
            mainView.addSubview(currentPractice)
            currentPractice.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
    
    lazy var correctBottomView: CorrectBottomView = CorrectBottomView(frame: CGRect(
        x: view.frame.minX,
        y: view.frame.maxY,
        width: view.frame.width,
        height: view.frame.height
    ))
    
    lazy var incorrectBottomView: IncorrectBottomView = IncorrectBottomView(frame: CGRect(
        x: view.frame.minX,
        y: view.frame.maxY,
        width: view.frame.width,
        height: view.frame.height
    ))
    
    lazy var similarityBottomView: SimilarityBottomView = SimilarityBottomView(frame: CGRect(
        x: view.frame.minX,
        y: view.frame.maxY,
        width: view.frame.width,
        height: view.frame.height
    ))
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        updateLayouts()
        
        nextPractice()
        
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
    }

    func updateViews() {
        view.backgroundColor = Theme.backgroundColor
        
        view.addSubview(mainView)
        view.addSubview(correctBottomView)
        view.addSubview(incorrectBottomView)
        view.addSubview(similarityBottomView)

        view.addSubview(button)
    }
    
    func updateLayouts() {
        mainView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(130)
        }
        
        button.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainView.snp.bottom).offset(60)
            make.height.equalTo(50)
        }
    }
    
    func updateValues(lesson: Lesson) {
        self.lesson = lesson
    }
}

extension PracticeViewController {
    
    // MARK: - Functions
    
    private func nextPractice() {
        let practiceId = getPracticeId()
        switch practiceId {
        case 0:
            currentPractice = WordChoicePractice()
            (currentPractice as! WordChoicePractice).updateValues(lesson: lesson, practiceType: .el2en, delegate: self)
        case 1:
            currentPractice = WordChoicePractice()
            (currentPractice as! WordChoicePractice).updateValues(lesson: lesson, practiceType: .en2el, delegate: self)
        case 2:
            currentPractice = ClozePractice()
            (currentPractice as! ClozePractice).updateValues(lesson: lesson, delegate:self)
        case 3:
            currentPractice = TranslationPractice()
            (currentPractice as! TranslationPractice).updateValues(lesson: lesson, practiceType: .el2en, delegate: self)
        case 4:
            currentPractice = TranslationPractice()
            (currentPractice as! TranslationPractice).updateValues(lesson: lesson, practiceType: .en2el, delegate: self)
        default:
            break
        }
    }
}

extension PracticeViewController {
    
    // MARK: - Utils
    
    private func getPracticeId() -> Int {
//        return Int(arc4random_uniform(5))
        return 0
    }
    
    internal func activateCheckButton() {
        button.activate()
    }
    
    internal func inactivateCheckButton() {
        button.inactivate()
    }
}

extension PracticeViewController {
    
    // MARK: - Actions
    
    @objc private func buttonTapped() {
        guard button.isActivated else { return }
        
        var yOffset = view.frame.maxY - mainView.frame.maxY
        
        if shouldCheck {
            similarity = currentPractice.check()
            if similarity == 1 {
                button.setToCorrectState()
                correctBottomView.floatUp(by: yOffset)
            } else if similarity == 0 {
                button.setToIncorrectState()
                incorrectBottomView.updateValues(answer: currentPractice.answer)
                incorrectBottomView.floatUp(by: yOffset + Theme.bodyFont.pointSize)
            } else {
                button.setToSimilarityState()
                similarityBottomView.updateValues(similarity: similarity, answer: currentPractice.answer, input: (currentPractice as! TranslationPractice).inputSentence)
                
                similarityBottomView.layoutIfNeeded()
                yOffset = similarityBottomView.label.frame.height
                
                similarityBottomView.floatUp(by: yOffset + 130)
                
            }
        } else {
            nextPractice()
            button.inactivate()
            
            if similarity == 1 {
                correctBottomView.floatDown(by: yOffset)
            } else if similarity == 0 {
                incorrectBottomView.clear()
                incorrectBottomView.floatDown(by: yOffset + Theme.bodyFont.pointSize)
            } else {
                similarityBottomView.clear()
                
                yOffset = similarityBottomView.label.frame.height
                similarityBottomView.floatDown(by: yOffset + 130)
            }
        }
        
        shouldCheck.toggle()
    }
}
