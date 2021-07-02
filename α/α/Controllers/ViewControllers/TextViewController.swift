//
//  TextsViewController.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var entries: [NSMutableAttributedString] = []
    
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
        let item = UIBarButtonItem(image: TextViewController.barButtonItemSystemImageWhenDisplayingLoop, style: .plain, target: self, action: #selector(barButtonItemTapped))
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
                let wordEntry = NSMutableAttributedString(string: word.wordEntry)
                let wordMeanings = NSMutableAttributedString(string: word.wordMeanings.replacingOccurrences(of: "\n\n", with: "\n"))
                wordMeanings.set(attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.gray,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
                ])
                let entry: NSMutableAttributedString = NSMutableAttributedString(string: "")
                entry.append(wordEntry)
                entry.append(NSMutableAttributedString(string: "\n"))
                entry.append(wordMeanings)
                
                // Tmp solution for "..."
                let additionalEndingString = NSMutableAttributedString(string: "[PAD]")
                additionalEndingString.set(attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightBlue])
                entry.append(additionalEndingString)
                
                entries.append(entry)
            }
        }
        if let sentences = sentences {
            for sentence in sentences {
                var entry: NSMutableAttributedString!
                if sentence.isEnglishTranslated {
                    entry = NSMutableAttributedString(string: sentence.greekSentence)
                } else if sentence.isGreekTranslated {
                    entry = NSMutableAttributedString(string: sentence.englishSentence)
                }
                
                // Tmp solution for "..."
                let additionalEndingString = NSMutableAttributedString(string: "[PAD]")
                additionalEndingString.set(attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightBlue])
                entry.append(additionalEndingString)
                
                entries.append(entry)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc func barButtonItemTapped() {
        if listView.isHidden {
            displayList()
        } else if loopView.isHidden {
            displayLoop()
        }
    }
    
    func displayList() {
        listView.isHidden = false
        loopView.isHidden = true
        displayListBarButtonItem.image = TextViewController.barButtonItemSystemImageWhenDisplayingList
    }
    
    // MARK: - Utils
    
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
        displayLoop()
        loopView.currentPage = indexPath.row
    }
}

extension TextViewController {
    static let tableViewRowHeight: CGFloat = UIScreen.main.bounds.height * 0.065
    static let tableViewCellReuseIdentifier = "TextTableViewCell"
    static let barButtonItemSystemImageWhenDisplayingList = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")
    static let barButtonItemSystemImageWhenDisplayingLoop = UIImage(systemName: "line.horizontal.3.decrease.circle")
}
