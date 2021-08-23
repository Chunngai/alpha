//
//  TextsViewController.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

typealias LessonSearchResult = Lesson

class TextViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var shouldBeBriefInDetailedCardViewAtFirst: Bool!
    var shouldDisplayListAtFirst: Bool!
    var shouldBeBriefContentInListAtFirst: Bool!
    
    var searchedVocabOrSentences = LessonContainer()
    var dataSource: LessonContainer {
        if !searchBar.isEmpty {
            return searchedVocabOrSentences
        } else {
            return allVocabOrSentences
        }
    }
    
    // MARK: - Models
    
    var allVocabOrSentences: LessonContainer!
    
    // MARK: - Views
    
    lazy var loopView: CardLoopView = {
        let loopView = CardLoopView()
        view.addSubview(loopView)
        
        loopView.updateValues(
            vocabOrSentences: flatten(dataSource),
            contentType: dataSource.contentTypeHavingInterestIn,
            isBrief: shouldBeBriefInDetailedCardViewAtFirst
        )
        loopView.isHidden = shouldDisplayListAtFirst ? true : false
        
        return loopView
    }()
    
    lazy var listView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            TextTableViewCell.classForCoder(),
            forCellReuseIdentifier: TextViewController.cellReuseIdentifier
        )
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = shouldDisplayListAtFirst ? false : true
        
        return tableView
    }()
    
    lazy var barButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(
            image: shouldDisplayListAtFirst ?
                TextViewController.barButtonItemForList :
                TextViewController.barButtonItemForLoop,
            style: .plain,
            target: self,
            action: #selector(barButtonItemTapped)
        )
        return item
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()

        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.isHidden = shouldDisplayListAtFirst ? false : true

        return searchBar
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        updateLayouts()
    }
    
    func updateViews() {        
        view.backgroundColor = Theme.backgroundColor
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.titleView = searchBar
    }
    
    func updateLayouts() {
        loopView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        listView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func updateValues(
        vocab: [Lesson]? = nil, sentences: [Lesson]? = nil,
        shouldInBriefAtFirst: Bool = true,
        shouldDisplayListAtFirst: Bool = false,
        shouldDisplayBriefWordContentAtFirst: Bool = false
    ) {
        if let vocab = vocab {
            self.allVocabOrSentences = LessonContainer(vocab: vocab)
            self.searchedVocabOrSentences.contentTypeHavingInterestIn = .vocab
        } else if let sentences = sentences {
            self.allVocabOrSentences = LessonContainer(sentences: sentences)
            self.searchedVocabOrSentences.contentTypeHavingInterestIn = .sentences
        }
        
        self.shouldBeBriefInDetailedCardViewAtFirst = shouldInBriefAtFirst
        self.shouldDisplayListAtFirst = shouldDisplayListAtFirst
        self.shouldBeBriefContentInListAtFirst = shouldDisplayBriefWordContentAtFirst
    }
}

extension TextViewController {
    // MARK: - Actions
    
    @objc func barButtonItemTapped() {
        if listView.isHidden {
            displayList()
            scrollToCellOf(loopView.currentWordOrSentence)
        } else if loopView.isHidden {
            displayLoop()
        }
    }
}

extension TextViewController {
    // MARK: - Functions
    
    func displayList() {
        listView.isHidden = false
        loopView.isHidden = true
        barButtonItem.image = TextViewController.barButtonItemForList
        searchBar.isHidden = false
    }
    
    func displayLoop() {
        listView.isHidden = true
        loopView.isHidden = false
        barButtonItem.image = TextViewController.barButtonItemForLoop
        searchBar.isHidden = true
    }
}

extension TextViewController {
    // MARK: - Utils
    
    func flatten(_ listToFlatten: LessonContainer) -> [WordOrSentence] {
        var flattenedList: [WordOrSentence] = []
        for lesson in listToFlatten.lessons {
            flattenedList.append(contentsOf: lesson.content(of: listToFlatten.contentTypeHavingInterestIn)!)
        }
        return flattenedList
    }
    
    func indexPathOf(_ wordOrSentence: WordOrSentence) -> IndexPath {
        for (section, lesson) in dataSource.lessons.enumerated() {
            for (row, content) in lesson.content(of: dataSource.contentTypeHavingInterestIn)!.enumerated() {
                if content.equalsTo(wordOrSentence) {
                    return IndexPath(row: row, section: section)
                }
            }
        }
        return IndexPath(row: 0, section: 0)
    }
    
    func scrollToCellOf(_ wordOrSentence: WordOrSentence) {
        let indexPathOfCellToAttractAttention = indexPathOf(wordOrSentence)
        
        listView.scrollToRow(
            at: indexPathOfCellToAttractAttention,
            at: UITableView.ScrollPosition.middle,
            animated: false
        )
        if let cell = listView.cellForRow(at: indexPathOfCellToAttractAttention)
            as? TextTableViewCell {
            cell.attractAttention()
        }
    }
}

extension TextViewController {
    // MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.lessons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.lessons[section].content(of: dataSource.contentTypeHavingInterestIn)!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextViewController.cellReuseIdentifier)
            as! TextTableViewCell
        
        let section = indexPath.section
        let row = indexPath.row
                
        cell.updateValues(
            wordOrSentence: dataSource.lessons[section].content(of: dataSource.contentTypeHavingInterestIn)![row],
            contentType: dataSource.contentTypeHavingInterestIn,
            delegate: self,
            shouldDisplayBriefWordContentAtFirst: shouldBeBriefContentInListAtFirst
        )
        
        return cell
    }
}

extension TextViewController {
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lesson \(dataSource.lessons[section].id!)"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension TextViewController: TextTableViewCellDelegate {
    // MARK: - TextTableViewCell Delegate
    
    func switchToLoopView(for wordOrSentence: WordOrSentence) {
        displayLoop()
        loopView.switchToPageFor(wordOrSentence)
    }
}

extension TextViewController {
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedVocabOrSentences.lessons.removeAll(keepingCapacity: false)
        
        guard let keyWord = searchBar.text else { return }
        
        for lesson in allVocabOrSentences.lessons {
            var matchedWordsOrSentences: [Any] = []
            
            for wordOrSentence in lesson.content(of: allVocabOrSentences.contentTypeHavingInterestIn)! {
                var contentToMatch: String
                if allVocabOrSentences.havingInterestInVocab {
                    let word = wordOrSentence as! Word
                    contentToMatch = word.wordEntry
                        + word.wordMeanings
                        + (word.explanation ?? "")
                } else {
                    let sentence = wordOrSentence as! Sentence
                    contentToMatch = sentence.greekSentence
                    + sentence.englishSentence
                }
                
                if contentToMatch.caseAndDiacriticInsensitivelyContains(keyWord) {
                    matchedWordsOrSentences.append(wordOrSentence)
                }
            }
            
            if matchedWordsOrSentences.count > 0 {
                searchedVocabOrSentences.lessons.append(LessonSearchResult(
                    id: lesson.id,
                    vocab: allVocabOrSentences.havingInterestInVocab ? matchedWordsOrSentences as? [Word] : nil,
                    sentences: allVocabOrSentences.havingInterestInSentences ? matchedWordsOrSentences as? [Sentence] : nil
                ))
            }
        }
        
        loopView.updateValues(
            vocabOrSentences: flatten(dataSource),
            contentType: dataSource.contentTypeHavingInterestIn,
            isBrief: loopView.isBrief
        )
        listView.reloadData()
    }
}

extension TextViewController {
    static let cellReuseIdentifier = "TextTableViewCell"
    static let barButtonItemForList = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")
    static let barButtonItemForLoop = UIImage(systemName: "line.horizontal.3.decrease.circle")
}

protocol TextViewControllerCellDelegate {
    func attractAttention()
}

protocol TextViewControllerLoopViewDelegate {
    var currentWordOrSentence: WordOrSentence { get }
    
    func switchToPageFor(_ wordOrSentence: WordOrSentence)
}
