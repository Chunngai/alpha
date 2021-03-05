//
//  ViewController.swift
//  α
//
//  Created by Sola on 2021/1/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit
import SnapKit

class LessonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LessonTableViewCellDelegate, FunctionsViewControllerDelegate {
    
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
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
        
    
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
    
    // MARK: - FunctionsViewController Deleagte
    
    func learningButtonTapped(lesson: Lesson) {
        let learningViewController = LearningViewController()
        navigationController?.pushViewController(learningViewController, animated: true)
    }
    
    func vocabButtonTapped(lesson: Lesson) {
        guard lesson.vocab.count > 0 else { return }
        
        let vocabViewController = TextViewController()
        vocabViewController.updateValues(texts: lesson.vocab, type_: TextView.Type_.word)
        navigationController?.pushViewController(vocabViewController, animated: true)
    }
    
    func sentencesButtonTapped(lesson: Lesson) {
        guard lesson.sentences.count > 0 else { return }
        
        let sentencesViewController = TextViewController()
        sentencesViewController.updateValues(texts: lesson.sentences, type_: TextView.Type_.sent)
        navigationController?.pushViewController(sentencesViewController, animated: true)
    }
    
    func readingButtonTapped(lesson: Lesson) {
        
    }
    
    func testButtonTapped(lesson: Lesson) {
        
    }
}

extension LessonViewController {
    static let lessonCellReuseIdentifier = "LessonTableViewCell"
    static let tableViewEstimatedRowHeight: CGFloat = UIScreen.main.bounds.height * 0.145
    static let tableViewrowHeight: CGFloat = UIScreen.main.bounds.height * 0.067
}

