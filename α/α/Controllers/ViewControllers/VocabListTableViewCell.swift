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
        textView.textContainerInset = VocabListTableViewCell.textViewInset
        
        return textView
    }()
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        updateViews()
        updateLayouts()
    }
    
    func updateViews() {
        self.selectionStyle = .none
        self.backgroundColor = .white
    }
    
    func updateLayouts() {
        textView.snp.makeConstraints { (make) in
            make.height.width.equalToSuperview()
        }
    }
    
    func updateValues(word: Word, delegate: VocabListViewController) {
        self.word = word
        self.delegate = delegate
        
        textView.text = makeText()
        PosToken.highlightPosTokensInTextView(textView: textView)
    }
    
    // MARK: - Actions
    
    @objc func textViewTapped() {
        delegate.pushWordDetails(word: word)
    }
    
    // MARK: - Utils
    
    func makeText() -> String {
        var posTokens: [PosToken] = []
        for item in word.meanings {
            if let pos = item.pos {
                let posToken = PosToken(pos: pos)
                if !posTokens.contains(posToken) {
                    posTokens.append(posToken)
                }
            }
        }
        
        var text = ""
        for posToken in posTokens {
            text.append(posToken.token)
            text.append(" ")
        }
        text.append(word.wordEntry)
        return text
    }
}

extension VocabListTableViewCell {
    static let textViewInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
}

protocol VocabularyTableViewCellDelegate {
    func pushWordDetails(word: Word)
}
