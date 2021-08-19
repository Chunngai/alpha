//
//  TextsViewController.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Models
    
    var vocab: [Word]?
    var sentences: [Sentence]?
        
    // MARK: - Views
    
    var loopView: CardLoopView!
    
    lazy var listView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            TextTableViewCell.classForCoder(),
            forCellReuseIdentifier: TextViewController.tableViewCellReuseIdentifier
        )
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorStyle = .none
        tableView.isHidden = true
        
        return tableView
    }()
    
    lazy var displayListBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: TextViewController.barButtonItemSystemImageWhenDisplayingLoop, style: .plain, target: self, action: #selector(barButtonItemTapped))
        return item
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {        
        view.backgroundColor = .background
        navigationItem.rightBarButtonItem = displayListBarButtonItem

        // Temporary solution for word detail from vocab controller.
        // TODO: - Fix it.
        if let vocab = vocab, vocab.count == 1 {
            navigationItem.rightBarButtonItem = nil
        }
        
        // TODO: - Wrap the code here
        loopView = CardLoopView(frame: CGRect(
            x: 0,
            y: (navigationController?.navigationBar.frame.maxY)!,
            width: view.frame.width,
            height: view.frame.height - (navigationController?.navigationBar.frame.maxY)! - (navigationController?.navigationBar.frame.height)!)
        )
        view.addSubview(loopView)
        loopView.updateValues(vocab: vocab, sentences: sentences)
        
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
    
    // MARK: - Actions
    
    @objc func barButtonItemTapped() {
        if listView.isHidden {
            displayList()
        } else if loopView.isHidden {
            displayLoop()
        }
    }
    
    // MARK: - Utils
    
    func displayList() {
        listView.isHidden = false
        loopView.isHidden = true
        displayListBarButtonItem.image = TextViewController.barButtonItemSystemImageWhenDisplayingList
    }
    
    func displayLoop() {
        listView.isHidden = true
        loopView.isHidden = false
        displayListBarButtonItem.image = TextViewController.barButtonItemSystemImageWhenDisplayingLoop
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TextViewController.tableViewCellReuseIdentifier) as! TextTableViewCell
        if let vocab = vocab {
            cell.updateValues(word: vocab[indexPath.row])
        } else if let sentences = sentences {
            cell.updateValues(sentence: sentences[indexPath.row])
        }
        return cell
    }
}

extension TextViewController {
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        displayLoop()
        loopView.currentPage = indexPath.row
    }
}

extension TextViewController {
    static let tableViewRowHeight: CGFloat = UIScreen.main.bounds.height * 0.065
    static let tableViewCellReuseIdentifier = "TextTableViewCell"
    static let barButtonItemSystemImageWhenDisplayingList = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")
    static let barButtonItemSystemImageWhenDisplayingLoop = UIImage(systemName: "line.horizontal.3.decrease.circle")
//    static let posBackgroundColors: [String: UIColor] = [
//        "verb": UIColor.verbColor,
//        "noun": UIColor.systemYellow,
//        "pronoun": UIColor.systemOrange,
//        "adjective": UIColor.systemPink,
//        "adverb": UIColor.systemGreen,
//        "preposition": UIColor.systemPurple,
//        "conjunction": UIColor.brown,
//        "particle": UIColor.magenta
//    ]
}
