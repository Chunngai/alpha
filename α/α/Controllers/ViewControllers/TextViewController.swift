//
//  TextsViewController.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var entries: [String] = []
    
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
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isHidden = true
        
        return tableView
    }()
    
    lazy var displayListBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(
            title: "[=]",
            style: .plain,
            target: self,
            action: #selector(displayList)
        )
        return item
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = displayListBarButtonItem

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
        
        if let vocab = vocab {
            for word in vocab {
                entries.append(word.wordEntry)
            }
        }
        if let sentences = sentences {
            for sentence in sentences {
                var entry: String = ""
                if sentence.isEnglishTranslated {
                    entry = sentence.greekSentence
                } else if sentence.isGreekTranslated {
                    entry = sentence.englishSentence
                }
                entries.append(entry)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc func displayList() {
        listView.isHidden = false
        loopView.isHidden = true
    }
}

extension TextViewController {
    // MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextViewController.tableViewCellReuseIdentifier) as! TextTableViewCell
        cell.updateValues(entry: entries[indexPath.row])
        
        return cell
    }
}

extension TextViewController {
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listView.isHidden = true
        loopView.isHidden = false
        loopView.currentPage = indexPath.row
    }
}

extension TextViewController {
    static let tableViewRowHeight: CGFloat = UIScreen.main.bounds.height * 0.065
    static let tableViewCellReuseIdentifier = "TextTableViewCell"
}
