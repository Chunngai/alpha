//
//  ViewController.swift
//  α
//
//  Created by Sola on 2021/1/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeTableViewCellDelegate, MenuViewControllerDelegate {
    
    // MARK: - Models
    
    var lessons: [Lesson]!
    
    // MARK: - Views
    
    lazy var lessonTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            HomeTableViewCell.classForCoder(),
            forCellReuseIdentifier: HomeViewController.tableViewCellReuseIdentifier
        )
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
//        tableView.estimatedRowHeight = HomeViewController.tableViewEstimatedRowHeight
        tableView.rowHeight = HomeViewController.tableViewRowHeight
        
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
        
        // Cannot add the snippet of code below to the closure of lessonTableView.
        // There must be some code that accesses the lessonTableView
        // to activate it since it is lazy.
        lessonTableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

extension HomeViewController {
    // MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.tableViewCellReuseIdentifier) as! HomeTableViewCell
        cell.updateValues(lesson: lessons[indexPath.row], delegate: self)
        return cell
    }
}

extension HomeViewController {
    // MARK: - HomeTableViewCell Delegate
    
    func pushMenuViewController(lesson: Lesson) {
        let menuViewController = MenuViewController()
        menuViewController.updateValues(lesson: lesson, delegate: self)
        navigationController?.pushViewController(menuViewController, animated: true)
    }
}
 
extension HomeViewController {
    // MARK: - MenuViewController Deleagte
    
    func learningButtonTapped(lesson: Lesson) {
        let learningViewController = ContentViewController()
        learningViewController.updateValues(lessonId: lesson.id)
        navigationController?.pushViewController(learningViewController, animated: true)
    }
    
    func vocabButtonTapped(lesson: Lesson) {
        guard lesson.vocab.count > 0 else { return }
        
        let vocabViewController = TextViewController()
        vocabViewController.updateValues(vocab: lesson.vocab)
        navigationController?.pushViewController(vocabViewController, animated: true)
    }
    
    func sentencesButtonTapped(lesson: Lesson) {
        guard lesson.sentences.count > 0 else { return }
        
        let sentencesViewController = TextViewController()
        sentencesViewController.updateValues(sentences: lesson.sentences)
        navigationController?.pushViewController(sentencesViewController, animated: true)
    }
    
    func readingButtonTapped(lesson: Lesson) {
        
    }
    
    func testButtonTapped(lesson: Lesson) {
        guard lesson.sentences.count > 0 else { return }
        
        let testViewController = TestViewController()
        testViewController.updateValues(sentences: lesson.sentences)
        navigationController?.pushViewController(testViewController, animated: true)
    }
}

extension HomeViewController {
    static let tableViewCellReuseIdentifier = "HomeTableViewCell"
    static let tableViewEstimatedRowHeight: CGFloat = UIScreen.main.bounds.height * 0.145
    static let tableViewRowHeight: CGFloat = UIScreen.main.bounds.height * 0.065
}

