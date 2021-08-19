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
    
    lazy var loopView: CardLoopView = {
        // TODO: - Fix it
        let loopView = CardLoopView(
            frame: CGRect(
                x: 0,
                y: 88,
                width: 414,
                height: 764
            )
        )
        view.addSubview(loopView)
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
        navigationItem.rightBarButtonItem = barButtonItem
        
//        loopView = CardLoopView(frame: CGRect(
//            x: 0,
//            y: (navigationController?.navigationBar.frame.maxY)!,
//            width: view.frame.width,
//            height: view.frame.height - (navigationController?.navigationBar.frame.maxY)! - (navigationController?.navigationBar.frame.height)!)
//        )
        
        listView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.90)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func updateValues(vocab: [Word]? = nil, sentences: [Sentence]? = nil) {
        self.vocab = vocab
        self.sentences = sentences
        
        loopView.updateValues(vocab: vocab, sentences: sentences)
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
    static let cellReuseIdentifier = "TextTableViewCell"
    static let barButtonItemForList = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")
    static let barButtonItemForLoop = UIImage(systemName: "line.horizontal.3.decrease.circle")
}
