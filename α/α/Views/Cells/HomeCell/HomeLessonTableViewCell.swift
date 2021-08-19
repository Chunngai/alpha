//
//  HomeLessonTableViewCell.swift
//  α
//
//  Created by Sola on 2021/8/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class HomeLessonTableViewCell: HomeTableViewCell {
    
    // MARK: - Models
    
    var lesson: Lesson! {
        didSet {
            label.text = String(lesson.id)
            button.setTitle(lesson.title, for: .normal)
        }
    }
    
    // MARK: - Init
    
    func updateValues(lesson: Lesson, delegate: HomeViewController) {
        self.lesson = lesson
        
        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    @objc override func buttonTapped() {
        delegate.pushMenuViewController(lesson: lesson)
    }
}

protocol HomeLessonTableViewCellDelegate {
    func pushMenuViewController(lesson: Lesson)
}
