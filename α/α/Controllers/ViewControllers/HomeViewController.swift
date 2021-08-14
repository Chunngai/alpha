//
//  ViewController.swift
//  α
//
//  Created by Sola on 2021/1/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeLessonTableViewCellDelegate, HomeTextBookTableViewCellDelegate, MenuViewControllerDelegate {
    
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
            forCellReuseIdentifier: HomeViewController.homeLessonTableViewCellReuseIdentifier
        )
        tableView.register(
            HomeTextBookTableViewCell.classForCoder(),
            forCellReuseIdentifier: HomeViewController.homeTextBookTableViewCellReuseIdentifier
        )
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorStyle = .none
        tableView.rowHeight = HomeViewController.tableViewRowHeight
        
        return tableView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lessons = TextBook.loadLessons()
        
        initViews()
    }

    func initViews() {
        navigationItem.title = "Ελληνική"
        view.backgroundColor = .background
        
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
            return 1
        case 1:
            return lessons.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.homeTextBookTableViewCellReuseIdentifier) as! HomeTextBookTableViewCell
            cell.updateValues(delegate: self)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.homeLessonTableViewCellReuseIdentifier) as! HomeLessonTableViewCell
            cell.updateValues(lesson: lessons[indexPath.row], delegate: self)
            return cell
        default:
            return UITableViewCell()
        }
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
    // MARK: - HomeTextBookTableViewCellDelegate
    
    func textBookButtonTapped() {
        let learningViewController = ContentViewController()
        learningViewController.updateValues(fileName: "textBook")
        navigationController?.pushViewController(learningViewController, animated: true)
    }
}
 
extension HomeViewController {
    // MARK: - MenuViewController Deleagte
    
    func learningButtonTapped(lesson: Lesson) {
        let learningViewController = ContentViewController()
        learningViewController.updateValues(fileName: lesson.pdfName)
        navigationController?.pushViewController(learningViewController, animated: true)
    }
    
    func vocabButtonTapped(lesson: Lesson) {
        guard lesson.vocab != nil && lesson.vocab!.count > 0 else { return }
        
        let vocabViewController = TextViewController()
        vocabViewController.updateValues(vocab: lesson.vocab!)
        navigationController?.pushViewController(vocabViewController, animated: true)
    }
    
    func sentencesButtonTapped(lesson: Lesson) {
        guard lesson.sentences != nil && lesson.sentences!.count > 0 else { return }
        
        let sentencesViewController = TextViewController()
        sentencesViewController.updateValues(sentences: lesson.sentences!)
        navigationController?.pushViewController(sentencesViewController, animated: true)
    }
    
    func readingButtonTapped(lesson: Lesson) {
        guard lesson.reading != nil else { return }
        
        let readingViewController = ReadingViewController()
        readingViewController.updateValues(reading: lesson.reading!)
        navigationController?.pushViewController(readingViewController, animated: true)
    }
    
    func testButtonTapped(lesson: Lesson) {
        guard lesson.sentences != nil && lesson.sentences!.count > 0 else { return }
        
        let testViewController = TestViewController()
        testViewController.updateValues(sentences: lesson.sentences!)
        navigationController?.pushViewController(testViewController, animated: true)
    }
}

extension HomeViewController {
    static let homeLessonTableViewCellReuseIdentifier = "HomeLessonTableViewCell"
    static let homeTextBookTableViewCellReuseIdentifier = "HomeTextBookTableViewCell"
    static let tableViewEstimatedRowHeight: CGFloat = UIScreen.main.bounds.height * 0.145
    static let tableViewRowHeight: CGFloat = UIScreen.main.bounds.height * 0.065
}

