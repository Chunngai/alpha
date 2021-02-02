//
//  ViewController.swift
//  α
//
//  Created by Sola on 2021/1/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit
import SnapKit

class LessonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LessonTableViewCellDelegate {
    
    // MARK: - Models
    
    var lessons: [Lesson]!
    
    // MARK: - Views
    
    lazy var lessonTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LessonTableViewCell.classForCoder(), forCellReuseIdentifier: LessonViewController.lessonCellReuseIdentifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = LessonViewController.tableViewEstimatedRowHeight
        tableView.rowHeight = LessonViewController.tableViewrowHeight
        
        return tableView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lessons = Lesson.loadLessons()
        
        initViews()
    }

    func initViews() {
        navigationItem.title = "Lessons"
        
        lessonTableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(LessonViewController.tableViewWidthRatio)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Utils
    
    
    // MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonViewController.lessonCellReuseIdentifier) as! LessonTableViewCell
        cell.updateValues(lesson: lessons[indexPath.row], delegate: self)
        
        return cell
    }
    
    // MARK: - LessonTableViewCell Delegate
    
    func displayFunctionViewController(lesson: Lesson) {
        let functionSelectionViewController = FunctionsViewController()
        functionSelectionViewController.updateValues(lesson: lesson, delegate: self)
        navigationController?.pushViewController(functionSelectionViewController, animated: true)
    }
}

extension LessonViewController {
    static let tableViewWidthRatio: CGFloat = 0.95
    static let lessonCellReuseIdentifier = "LessonTableViewCell"
    static let tableViewEstimatedRowHeight: CGFloat = UIScreen.main.bounds.height * 0.145
    static let tableViewrowHeight: CGFloat = UIScreen.main.bounds.height * 0.067
}

