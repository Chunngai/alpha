//
//  ViewController.swift
//  α
//
//  Created by Sola on 2021/1/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit
import SnapKit

class LessonViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Models
    
    var lessons: [Lesson]!
    
    // MARK: - Views
    
    lazy var lessonCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LessonCollectionViewCell.self, forCellWithReuseIdentifier: LessonViewController.lessonCellReuseIdentifier)
        collectionView.register(LessonCollectionViewReviewCell.self, forCellWithReuseIdentifier: LessonViewController.reviewCellReuseIdentifier)
        
        return collectionView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessons = Lesson.loadLessons()
        
        initViews()
    }

    func initViews() {
        navigationItem.title = "Lessons"
        
        lessonCollectionView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(LessonViewController.collectionViewFrameWidthRatio)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Utils
    
    static func getLessonIndex(indexPath: IndexPath) -> Int {
        let section = indexPath.section
        let row = indexPath.row
        return ((section - 1) * LessonViewController.numberOfItemsInSection + row)
    }
    
    // MARK: - UICollectionView Date Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Int(ceil(Float(lessons.count) / Float(LessonViewController.numberOfItemsInSection))) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == LessonViewController.reviewSection {
            return 1
        } else {
            return LessonViewController.numberOfItemsInSection
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: create a cell
        if indexPath.section == LessonViewController.reviewSection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonViewController.reviewCellReuseIdentifier, for: indexPath) as! LessonCollectionViewReviewCell
            cell.updateValues(delegate: self)
            return cell
        }
        
        var lesson: Lesson? = nil
        let lessonIndex = LessonViewController.getLessonIndex(indexPath: indexPath)
        if lessonIndex < lessons.count {
            lesson = lessons[lessonIndex]
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonViewController.lessonCellReuseIdentifier, for: indexPath) as! LessonCollectionViewCell
        cell.updateValues(lesson: lesson, delegate: self)
        
        // FIXME: Do something when the cell has no lesson
        if lesson == nil {
            cell.lessonButton.backgroundColor = collectionView.backgroundColor
        }
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize: CGFloat = CGFloat(Int(
            view.bounds.width
                * LessonViewController.collectionViewFrameWidthRatio
                / CGFloat(LessonViewController.numberOfItemsInSection)
        ))
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        if indexPath == IndexPath(row: 0, section: 0) {
            width = CGFloat(Int(
                collectionView.frame.width
                - itemSize * (1 - LessonCollectionViewCell.sizeRatio)
            ))
        } else {
            width = itemSize
        }
        height = itemSize
        
        return CGSize(width: width, height: height)
    }
}

extension LessonViewController {
    static let reviewSection: Int = 0
    static let collectionViewFrameWidthRatio: CGFloat = 0.95
    static let numberOfItemsInSection: Int = 5
    static let lessonCellReuseIdentifier = "lessonCollectionViewCell"
    static let reviewCellReuseIdentifier = "lessonCollectionViewReviewCell"
}
