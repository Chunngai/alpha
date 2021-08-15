//
//  ViewController.swift
//  α
//
//  Created by Sola on 2021/1/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeLessonTableViewCellDelegate, HomeIndexTableViewCellDelegate, MenuViewControllerDelegate {
    
    lazy var indexCellMapping: [(title: String, funcWhenTapped: () -> Void)] = [
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
            forCellReuseIdentifier: HomeViewController.homeLessonTableViewCellReuseIdentifier
        )
        tableView.register(
            HomeIndexTableViewCell.classForCoder(),
            forCellReuseIdentifier: HomeViewController.homeIndexTableViewCellReuseIdentifier
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
        navigationItem.largeTitleDisplayMode = .always
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
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.homeIndexTableViewCellReuseIdentifier) as! HomeIndexTableViewCell
            cell.updateValues(buttonTitle: indexCellMapping[row].title, funcWhenTapped: indexCellMapping[row].funcWhenTapped)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.homeLessonTableViewCellReuseIdentifier) as! HomeLessonTableViewCell
            cell.updateValues(lesson: lessons[row], delegate: self)
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
    // MARK: - HomeIndexTableViewCell Delegate
    
    func textBookButtonTapped() {
        let learningViewController = ContentViewController()
        learningViewController.navigationItem.largeTitleDisplayMode = .never
        learningViewController.updateValues(fileName: "textBook")
        navigationController?.pushViewController(learningViewController, animated: true)
    }
    
    func vocabularyButtonTapped() {
        let vocabularyViewController = VocabularyViewController()
        vocabularyViewController.updateValues(lessons: lessons)
        navigationController?.pushViewController(vocabularyViewController, animated: true)
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
    static let homeIndexTableViewCellReuseIdentifier = "HomeIndexTableViewCell"
    static let tableViewEstimatedRowHeight: CGFloat = UIScreen.main.bounds.height * 0.145
    static let tableViewRowHeight: CGFloat = UIScreen.main.bounds.height * 0.065
}
