//
//  FunctionSelectionViewController.swift
//  α
//
//  Created by Sola on 2021/1/16.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class FunctionsViewController: UIViewController {

    // MARK: - Models
    
    var lesson: Lesson!
    
    // MARK: - Controllers
    
    var delegate: LessonViewController!
    
    // MARK: - Views
    
    lazy var functionStackView: UIStackView = {
        let learningButtonView = FunctionButtonView()
        learningButtonView.updateValues(title: "Learning")
        learningButtonView.button.addTarget(self, action: #selector(learningButtonTapped), for: .touchUpInside)
        
        let vocabButtonView = FunctionButtonView()
        vocabButtonView.updateValues(title: "Vocab")
        vocabButtonView.button.addTarget(self, action: #selector(vocabButtonTapped), for: .touchUpInside)
        
        let sentencesButtonView = FunctionButtonView()
        sentencesButtonView.updateValues(title: "Sentences")
        sentencesButtonView.button.addTarget(self, action: #selector(sentencesButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [learningButtonView, vocabButtonView, sentencesButtonView])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        learningButtonView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        vocabButtonView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        sentencesButtonView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        
        return stackView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Lesson \(lesson.id)"
        
        view.backgroundColor = .white
        
        functionStackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview()
        }
        
        if lesson.vocab.count == 0 {
            let vocabButtonView = functionStackView.arrangedSubviews[1] as! FunctionButtonView
            vocabButtonView.button.backgroundColor = .lightGray
        }
        if lesson.sentences.count == 0 {
            let sentencesButtonView = functionStackView.arrangedSubviews[2] as! FunctionButtonView
            sentencesButtonView.button.backgroundColor = .lightGray
        }
    }
    
    func updateValues(lesson: Lesson, delegate: LessonViewController) {
        self.lesson = lesson

        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    @objc func learningButtonTapped() {
        let learningViewController = LearningViewController()
        delegate.navigationController?.pushViewController(learningViewController, animated: true)
    }
    
    @objc func vocabButtonTapped() {
        guard lesson.vocab.count > 0 else { return }
        
        let vocabViewController = TextViewController()
        vocabViewController.updateValues(texts: lesson.vocab)
        delegate.navigationController?.pushViewController(vocabViewController, animated: true)
    }
    
    @objc func sentencesButtonTapped() {
        guard lesson.sentences.count > 0 else { return }
        
        let sentencesViewController = TextViewController()
        sentencesViewController.updateValues(texts: lesson.sentences)
        delegate.navigationController?.pushViewController(sentencesViewController, animated: true)
    }
}
