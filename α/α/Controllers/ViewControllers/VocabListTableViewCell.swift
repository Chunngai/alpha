//
//  VocabularyTableViewCell.swift
//  α
//
//  Created by Sola on 2021/8/18.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class VocabListTableViewCell: UITableViewCell {
    
    // MARK: - Models
    
    var word: Word!
    
    // MARK: - Controllers
    
    var delegate: VocabListViewController!
    
    // MARK: - Views
    
    lazy var textView: RoundCornersBgTextView = {        
        let textView = RoundCornersBgTextView(frame: CGRect.zero, textContainerSize: self.contentView.bounds.size)
        contentView.addSubview(textView)
        
        textView.addGestureRecognizer({
            let recognizer = UITapGestureRecognizer()
            recognizer.addTarget(self, action: #selector(textViewTapped))
            return recognizer
        }())
        
        textView.backgroundColor = contentView.backgroundColor
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = Theme.bodyFont
        textView.contentInset = VocabListTableViewCell.contentInset
        
        return textView
    }()
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        updateInitialViews()
    }
    
    func updateInitialViews() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        textView.snp.makeConstraints { (make) in
            make.height.width.equalToSuperview()
        }
    }
    
    func updateValues(word: Word, delegate: VocabListViewController) {
        self.word = word
        self.delegate = delegate
        
        let posTokenList: [String] = getPosTokenList(wordMeanings: word.meanings)
        textView.text = posTokenList.joined(separator: " ") + " " + word.wordEntry
        highlightPosToken(in: posTokenList)
    }
    
    // MARK: - Actions
    
    @objc func textViewTapped() {
        delegate.pushWordDetails(word: word)
    }
    
    // MARK: - Utils
    
    func getPosTokenList(wordMeanings: [Word.Meanings]) -> [String] {
        var list: [String] = []
        for item in wordMeanings {
            let pos = Word.posAbbr[item.pos]
            if let pos = pos {
                let posToken = pos.indent(leftIndent: 1, rightIndent: 1)
                if !list.contains(posToken) {
                    list.append(posToken)
                }
            }
        }
        return list
    }
    
    func highlightPosToken(in posTokenList: [String]) {
        for posToken in posTokenList {
            textView.textStorage.setAttributes(
                VocabListTableViewCell.posAttributes,
                range: textView.text!.nsrange(of: posToken, options: String.caseAndDiacriticInsensitiveCompareOptions)!
            )
        }
    }
}

extension VocabListTableViewCell {
    static let contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    static let posAttributes: [NSAttributedString.Key: Any] = [
        .backgroundColor : Theme.lightBlue,
        .font: Theme.bodyFont
    ]
}

protocol VocabularyTableViewCellDelegate {
    func pushWordDetails(word: Word)
}
