//
//  ViewController.swift
//  α
//
//  Created by Sola on 2021/1/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeIndexTableViewCellDelegate, HomeLessonTableViewCellDelegate {
    
    lazy var indexCellTitleFuncMapping: [(title: String, funcWhenTapped: () -> Void)] = [
        (title: "Text Book", funcWhenTapped: textBookButtonTapped),
        (title: "Vocabulary", funcWhenTapped: vocabularyButtonTapped)
    ]
    
    // MARK: - Models
    
    var lessons: [Lesson]!
    
    // MARK: - Views
    
    lazy var lessonTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            HomeLessonTableViewCell.classForCoder(),
            forCellReuseIdentifier: HomeViewController.lessonCellReuseIdentifier
        )
        tableView.register(
            HomeIndexTableViewCell.classForCoder(),
            forCellReuseIdentifier: HomeViewController.indexCellReuseIdentifier
        )
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorStyle = .none
        tableView.rowHeight = HomeViewController.tableViewRowHeight
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lessons = TextBook.loadLessons()
        
        updateViews()
    }

    func updateViews() {
        navigationItem.title = "Ελληνική"
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = Theme.backgroundColor
        
        // Cannot add the snippet of code below to the closure of lessonTableView.
        // There must be some code that accesses the lessonTableView
        // to activate it since it is lazy.
        lessonTableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.90)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

extension HomeViewController {
    // MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 2
        case 1:
            return lessons.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        switch (section) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.indexCellReuseIdentifier) as! HomeIndexTableViewCell
            cell.updateValues(buttonTitle: indexCellTitleFuncMapping[row].title, funcWhenTapped: indexCellTitleFuncMapping[row].funcWhenTapped)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.lessonCellReuseIdentifier) as! HomeLessonTableViewCell
            cell.updateValues(lesson: lessons[row], delegate: self)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension HomeViewController {
    // MARK: - HomeIndexTableViewCell Delegate
    
    func textBookButtonTapped() {
        let learningViewController = PDFViewController()
        learningViewController.updateValues(fileName: "textBook")
        navigationController?.pushViewController(learningViewController, animated: true)
    }
    
    func vocabularyButtonTapped() {
        let vocabularyViewController = VocabListViewController()
        vocabularyViewController.updateValues(lessons: lessons)
        navigationController?.pushViewController(vocabularyViewController, animated: true)
    }
}

extension HomeViewController {
    // MARK: - HomeLessonTableViewCell Delegate
    
    func pushMenuViewController(lesson: Lesson) {
        let menuViewController = MenuViewController()
        menuViewController.updateValues(lesson: lesson)
        navigationController?.pushViewController(menuViewController, animated: true)
    }
}

extension HomeViewController {
    static let lessonCellReuseIdentifier = "HomeLessonTableViewCell"
    static let indexCellReuseIdentifier = "HomeIndexTableViewCell"
    static let tableViewRowHeight: CGFloat = 58
}
