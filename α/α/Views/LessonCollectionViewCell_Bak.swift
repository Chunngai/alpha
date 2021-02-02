//
//  LessonCollectionViewCell.swift
//  α
//
//  Created by Sola on 2021/1/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class LessonCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Models
    
    var lesson: Lesson!
    
    // MARK: - Controllers
    
    // TODO: protocol
    var delegate: LessonViewController!
    
    // MARK: - Views

    lazy var view: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var lessonButton: UIButton = {
        let button = UIButton()
        view.addSubview(button)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont(name: "Chalkduster", size: LessonCollectionViewCell.fontSize)
        button.addTarget(self, action: #selector(lessonButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
            
    func updateViews() {
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(LessonCollectionViewCell.sizeRatio)
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
    
    func updateValues(lesson: Lesson?, delegate: LessonViewController) {
        self.lesson = lesson
        
        self.delegate = delegate
        
        if let lesson = lesson {
            lessonButton.setTitle(String(lesson.id), for: .normal)
        } else {
            lessonButton.setTitle("", for: .normal)
        }
    }
    
    // MARK: - Actions
    @objc func lessonButtonTapped() {
        if let lesson = lesson {
            let functionSelectionViewController = FunctionsViewController()
            functionSelectionViewController.updateValues(lesson: lesson, delegate: delegate)
            delegate.navigationController?.pushViewController(functionSelectionViewController, animated: true)
        }
    }
}

extension LessonCollectionViewCell {
    static let sizeRatio: CGFloat = 0.9
    static let fontSize: CGFloat = UIScreen.main.bounds.width * 0.05
}
