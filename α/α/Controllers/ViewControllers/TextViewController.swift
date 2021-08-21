//
//  TextsViewController.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TextTableViewCellDelegate {
    
    // From vocab: tapped word; for single lesson: first word.
    var indexOfWordToDisplayFirst: Int!
    // From vocab: false; for single lesson: true.
    var shouldInBriefAtFirst: Bool!
        
    // MARK: - Models
    
    var vocab: [Word]?
    var sentences: [Sentence]?
    
    // MARK: - Views
    
    lazy var loopView: CardLoopView = {
        let loopView = CardLoopView()
        view.addSubview(loopView)
        
        loopView.updateValues(
            vocab: vocab,
            sentences: sentences,
            indexOfWordToDisplayFirst: indexOfWordToDisplayFirst,
            isBrief: shouldInBriefAtFirst
        )
        
        return loopView
    }()
    
    lazy var listView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            TextTableViewCell.classForCoder(),
            forCellReuseIdentifier: TextViewController.cellReuseIdentifier
        )
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorStyle = .singleLine
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    lazy var barButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: TextViewController.barButtonItemForLoop, style: .plain, target: self, action: #selector(barButtonItemTapped))
        return item
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
    
    func updateValues(vocab: [Word]? = nil, sentences: [Sentence]? = nil, indexOfWordToDisplayFirst: Int = 0, shouldInBriefAtFirst: Bool = true) {
        self.vocab = vocab
        self.sentences = sentences
        self.indexOfWordToDisplayFirst = indexOfWordToDisplayFirst
        self.shouldInBriefAtFirst = shouldInBriefAtFirst
    }
}

extension TextViewController {
    // MARK: - Actions
    
    @objc func barButtonItemTapped() {
        if listView.isHidden {
            displayList()
            
            let indexPathOfCellToAttractAttention = IndexPath(row: loopView.currentPage!, section: 0)
            listView.scrollToRow(
                at: indexPathOfCellToAttractAttention,
                at: UITableView.ScrollPosition.middle,
                animated: false
            )
            let cell = listView.cellForRow(at: indexPathOfCellToAttractAttention) as? TextTableViewCell
            if let cell = cell {
                cell.attractAttention()
            }
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
    }
    
    func displayLoop() {
        listView.isHidden = true
        loopView.isHidden = false
        barButtonItem.image = TextViewController.barButtonItemForLoop
    }
}

extension TextViewController {
    // MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let vocab = vocab {
            return vocab.count
        } else if let sentences = sentences {
            return sentences.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextViewController.cellReuseIdentifier) as! TextTableViewCell
        if let vocab = vocab {
            cell.updateValues(word: vocab[indexPath.row], delegate: self, cellId: indexPath.row)
        } else if let sentences = sentences {
            cell.updateValues(sentence: sentences[indexPath.row], delegate: self, cellId: indexPath.row)
        }
        return cell
    }
}

extension TextViewController {
    // MARK: - TextTableViewCell Delegate
    
    func switchToLoopView(cellId: Int) {
        displayLoop()
        loopView.switchTo(page: cellId)
    }
}

extension TextViewController {
    static let cellReuseIdentifier = "TextTableViewCell"
    static let barButtonItemForList = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")
    static let barButtonItemForLoop = UIImage(systemName: "line.horizontal.3.decrease.circle")
}

protocol TextViewControllerDelegate {
    func attractAttention()
}
