//
//  TextsViewController.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TextTableViewCellDelegate {
    
    var isSingleMode: Bool {
        if let vocab = vocab {
            return vocab.count == 1
        } else if let sentences = sentences {
            return sentences.count == 1
        } else {
            return false
        }
    }
    
    // MARK: - Models
    
    var vocab: [Word]?
    var sentences: [Sentence]?
    
    // MARK: - Views
    
    lazy var loopView: CardLoopView = {
        let loopView = CardLoopView()
        view.addSubview(loopView)
        
        loopView.updateValues(vocab: vocab, sentences: sentences)
        
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
        tableView.separatorStyle = .none
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
    }
    
    func updateViews() {        
        view.backgroundColor = Theme.backgroundColor
        if !isSingleMode {
            navigationItem.rightBarButtonItem = barButtonItem
        }
        
        loopView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        if isSingleMode {
            loopView.loopScrollView.isScrollEnabled = false
        }
        
        listView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.90)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func updateValues(vocab: [Word]? = nil, sentences: [Sentence]? = nil) {
        self.vocab = vocab
        self.sentences = sentences
    }
}

extension TextViewController {
    // MARK: - Actions
    
    @objc func barButtonItemTapped() {
        if listView.isHidden {
            displayList()
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
        loopView.currentPage = cellId
    }
}

extension TextViewController {
    static let cellReuseIdentifier = "TextTableViewCell"
    static let barButtonItemForList = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")
    static let barButtonItemForLoop = UIImage(systemName: "line.horizontal.3.decrease.circle")
}
