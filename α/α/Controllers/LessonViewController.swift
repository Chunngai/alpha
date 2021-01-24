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
        let itemSize: CGFloat = CGFloat(Int(
            view.bounds.width
                * LessonViewController.collectionViewFrameWidthRatio
                / CGFloat(LessonViewController.numberOfItemsInSection)
        ))
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        collectionViewLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LessonCollectionViewCell.self, forCellWithReuseIdentifier: LessonViewController.reuseIdentifier)
        
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
        return (section * LessonViewController.numberOfItemsInSection + row)
    }
    
    // MARK: - UICollectionView Date Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Int(ceil(Float(lessons.count) / Float(LessonViewController.numberOfItemsInSection)))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LessonViewController.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var lesson: Lesson? = nil
        let lessonIndex = LessonViewController.getLessonIndex(indexPath: indexPath)
        if lessonIndex < lessons.count {
            lesson = lessons[lessonIndex]
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonViewController.reuseIdentifier, for: indexPath) as! LessonCollectionViewCell
        cell.updateValues(lesson: lesson, delegate: self)
        return cell
    }
    
    // MARK: - UICollectionView Delegate
}

extension LessonViewController {
    static let collectionViewFrameWidthRatio: CGFloat = 0.95
    static let numberOfItemsInSection: Int = 5
    static let reuseIdentifier = "lessonCollectionViewCell"
}
