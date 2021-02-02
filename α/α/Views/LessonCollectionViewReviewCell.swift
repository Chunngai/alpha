//
//  LessonCollectionViewReviewCell.swift
//  α
//
//  Created by Sola on 2021/1/24.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class LessonCollectionViewReviewCell: LessonCollectionViewCell {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateViews() {
        lessonButton.setTitle("Review", for: .normal)
        
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(LessonCollectionViewCell.sizeRatio)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        lessonButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func updateValues(delegate: LessonViewController) {
        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    @objc override func lessonButtonTapped() {
        // TODO: - User select
        let texts = getReviewContent(fromLesson: 1, toLesson: 5)
                
        let vocabViewController = TextViewController()
        vocabViewController.updateValues(texts: texts)
        delegate.navigationController?.pushViewController(vocabViewController, animated: true)
    }
    
    // MARK: - Utils
    
    func rand(lowerBound: Int, upperBound: Int) -> Int {
        let upperBound_ = upperBound + 1
        return Int(arc4random_uniform(UInt32(upperBound_ - lowerBound))) + lowerBound
    }
    
    func getReviewContent(fromLesson: Int, toLesson: Int) -> [Text] {
        var reviewContent: [Text] = []
        
        let fromLessonIndex = fromLesson - 1
        let toLessonIndex = toLesson - 1
        let lessons = Lesson.loadLessons()
        for _ in 0...100 {
            let randomlySelectedLessonIndex = rand(lowerBound: fromLessonIndex, upperBound: toLessonIndex)
            let lesson = lessons[randomlySelectedLessonIndex]
            
            if lesson.vocab.count > 0 {
                let fromWordIndex = 0
                let toWordIndex = lesson.vocab.count - 1
                let randomlySelectedWordIndex = rand(lowerBound: fromWordIndex, upperBound: toWordIndex)
                let word = lesson.vocab[randomlySelectedWordIndex]
                reviewContent.append(word)
            }
            
            if lesson.sentences.count > 0 {
                // TODO: select a sentence containing the word
                reviewContent.append(lesson.sentences[0])
            }
        }
        
        return reviewContent
    }
}
