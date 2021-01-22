//
//  FunctionSelectionViewController.swift
//  α
//
//  Created by Sola on 2021/1/16.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class FunctionSelectionViewController: UIViewController {

    // MARK: - Models
    
    var lesson: Lesson!
    
    // MARK: - Controllers
    
    var delegate: LessonViewController!
    
    // MARK: - Views
    
    let functionStackView: UIStackView = {
        let learningButton = UIButton()
        learningButton.setTitle("Learning", for: .normal)
        learningButton.setTitleColor(FunctionSelectionViewController.buttonTitleColor, for: .normal)
        learningButton.backgroundColor = FunctionSelectionViewController.buttonBackgroungColor
        learningButton.layer.cornerRadius = FunctionSelectionViewController.buttonLayerCornerRadius
        learningButton.addTarget(self, action: #selector(learningButtonTapped), for: .touchUpInside)
        
        let learningView = UIView()
        learningView.addSubview(learningButton)
        learningButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.98)
            make.height.equalToSuperview().multipliedBy(0.98)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        let vocabButton = UIButton()
        vocabButton.setTitle("Vocab", for: .normal)
        vocabButton.setTitleColor(FunctionSelectionViewController.buttonTitleColor, for: .normal)
        vocabButton.backgroundColor = FunctionSelectionViewController.buttonBackgroungColor
        vocabButton.layer.cornerRadius = FunctionSelectionViewController.buttonLayerCornerRadius
        vocabButton.addTarget(self, action: #selector(vocabButtonTapped), for: .touchUpInside)
        let vocabView = UIView()
        vocabView.addSubview(vocabButton)
        vocabButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.98)
            make.height.equalToSuperview().multipliedBy(0.98)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        let sentencesButton = UIButton()
        sentencesButton.setTitle("Sentences", for: .normal)
        sentencesButton.setTitleColor(FunctionSelectionViewController.buttonTitleColor, for: .normal)
        sentencesButton.backgroundColor = FunctionSelectionViewController.buttonBackgroungColor
        sentencesButton.layer.cornerRadius = FunctionSelectionViewController.buttonLayerCornerRadius
        sentencesButton.addTarget(self, action: #selector(sentencesButtonTapped), for: .touchUpInside)
        let sentencesView = UIView()
        sentencesView.addSubview(sentencesButton)
        sentencesButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.98)
            make.height.equalToSuperview().multipliedBy(0.98)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        let stackView = UIStackView(arrangedSubviews: [learningView, vocabView, sentencesView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        learningView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        vocabView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        sentencesView.snp.makeConstraints { (make) in
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
        
        view.backgroundColor = .white
        
        view.addSubview(functionStackView)
        functionStackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview()
        }
//        functionStackView.frame = CGRect(x: 0, y: (navigationController?.navigationBar.frame.height)!, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (navigationController?.navigationBar.frame.height)!)
    }
    
    func updateValues(lesson: Lesson, delegate: LessonViewController) {
        self.lesson = lesson
        if lesson.vocab.count == 0 {
            functionStackView.arrangedSubviews[1].subviews[0].backgroundColor = .lightGray
        }
        if lesson.sentences.count == 0 {
            functionStackView.arrangedSubviews[2].subviews[0].backgroundColor = .lightGray
        }
        
        self.delegate = delegate
        
        navigationItem.title = "Lesson \(lesson.id)"
    }
    
    // MARK: - Actions
    
    @objc func learningButtonTapped() {
        let learningViewController = LearningViewController()
        delegate.navigationController?.pushViewController(learningViewController, animated: true)
    }
    
    @objc func vocabButtonTapped() {
        guard lesson.vocab.count > 0 else { return }
        
//        let vocabViewController = VocabAndSentencesViewController()
        let vocabViewController = TextViewController()
//        vocabViewController.updateValues(texts: lesson.vocab)
        delegate.navigationController?.pushViewController(vocabViewController, animated: true)
    }
    
    @objc func sentencesButtonTapped() {
        guard lesson.sentences.count > 0 else { return }
        
//        let sentencesViewController = VocabAndSentencesViewController()
        let sentencesViewController = TextViewController()
//        sentencesViewController.updateValues(texts: lesson.sentences, centerAlignment: false)
        delegate.navigationController?.pushViewController(sentencesViewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FunctionSelectionViewController {
    static let buttonTitleColor: UIColor = .white
    static let buttonBackgroungColor: UIColor = .black
    static let buttonLayerCornerRadius: CGFloat = 10
}
