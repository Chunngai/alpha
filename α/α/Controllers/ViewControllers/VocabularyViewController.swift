//
//  VocabularyViewController.swift
//  α
//
//  Created by Sola on 2021/8/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class VocabularyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, VocabularyTableViewCellDelegate {
    
    var dataSource: [(lessonId: Int, vocab: [Word])] {
        var dataSource: [(lessonId: Int, vocab: [Word])]
        if !searchBar.isEmpty {
            dataSource = searchedLessonIdsAndWords
        } else {
            dataSource = allLessonIdsAndWords
        }
        return dataSource
    }
    
    // MARK: - Models
    
    var allLessonIdsAndWords: [(lessonId: Int, vocab: [Word])] = []
    var searchedLessonIdsAndWords: [(lessonId: Int, vocab: [Word])] = []
    
    // MARK: - Views
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()

        searchBar.delegate = self
        searchBar.sizeToFit()

        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VocabularyTableViewCell.classForCoder(), forCellReuseIdentifier: VocabularyViewController.cellReuseIdentifier)
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorStyle = .singleLine
        
        return tableView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateInitialViews()
    }
    
    func updateInitialViews() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.titleView = searchBar
        view.backgroundColor = .background
                
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func updateValues(lessons: [Lesson]) {
        getWords(lessons: lessons)
    }
    
    // MARK: - Utils
    
    func getWords(lessons: [Lesson]) {
        for lesson in lessons {
            if let vocab = lesson.vocab {
                allLessonIdsAndWords.append((lessonId: lesson.id, vocab: vocab))
            }
        }
    }
}

extension VocabularyViewController {
    // MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].vocab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let word = dataSource[indexPath.section].vocab[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VocabularyViewController.cellReuseIdentifier) as! VocabularyTableViewCell
        cell.updateValues(word: word, delegate: self)
        return cell
    }
}

extension VocabularyViewController {
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lesson \(dataSource[section].lessonId)"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

extension VocabularyViewController {
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedLessonIdsAndWords.removeAll(keepingCapacity: false)
        
        guard let keyWord = searchBar.text else { return }
        
        for item in allLessonIdsAndWords {
            var matchedWords: [Word] = []
            for word in item.vocab {
                let wordContent = word.wordEntry + word.wordMeanings + (word.explanation ?? "")
                if wordContent.caseAndDiacriticInsensitivelyContains(keyWord) {
                    matchedWords.append(word)
                }
            }
            if matchedWords.count > 0 {
                searchedLessonIdsAndWords.append((lessonId: item.lessonId, vocab: matchedWords))
            }
        }
        
        tableView.reloadData()
    }
}

extension VocabularyViewController {
    // MARK: - VocabularyTableViewCell Delegate
    
    func pushWordDetails(word: Word) {
        let vocabViewController = TextViewController()
        vocabViewController.updateValues(vocab: [word])
        navigationController?.pushViewController(vocabViewController, animated: true)
    }
}

extension VocabularyViewController {
    static let cellReuseIdentifier = "VocabularyTableViewCell"
}
