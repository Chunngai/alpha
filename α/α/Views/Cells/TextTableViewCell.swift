//
//  TextTableViewCell.swift
//  α
//
//  Created by Sola on 2021/7/1.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
        
    var cellId: Int!
    
    // MARK: - Controllers
    
    var delegate: TextViewController!
    
    // MARK: - Views
    
    lazy var textView: RoundCornersBgTextView = {
        let textView = RoundCornersBgTextView(frame: CGRect.zero, textContainerSize: self.contentView.bounds.size)
        contentView.addSubview(textView)
        
        textView.addGestureRecognizer({
            let gestureRecognizer = UITapGestureRecognizer()
            gestureRecognizer.numberOfTapsRequired = 1
            gestureRecognizer.addTarget(self, action: #selector(textViewTapped))
            return gestureRecognizer
        }())
        
        textView.backgroundColor = .white
        textView.isEditable = false
        // The statement below makes contentSize.height be 0.
        textView.isScrollEnabled = false  // Wo it the cell height is not accurate.
        textView.contentInset = TextTableViewCell.textViewInsets
        
        return textView
    }()
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        updateViews()
    }
    
    func updateViews() {
        self.selectionStyle = .none
        self.backgroundColor = Theme.backgroundColor
        
        textView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    func updateValues(word: Word? = nil, sentence: Sentence? = nil, delegate: TextViewController, cellId: Int) {
        if let word = word {
            make(word: word)
        } else if let sentence = sentence {
            make(sentence: sentence)
        }
        
        self.delegate = delegate
        self.cellId = cellId
    }
}

extension TextTableViewCell {
    // MARK: - Actions
    
    @objc func textViewTapped() {
        delegate.switchToLoopView(cellId: cellId)
    }
}

extension TextTableViewCell {
    // MARK: - Utils
    
    func make(word: Word) {
        var text = ""
        text += word.wordEntry
        text += "\n"
        text += word.wordMeanings
        textView.text = text
        
        textView.textStorage.set(
            attributes: TextTableViewCell.grayTextAttributes
        )
        textView.textStorage.set(
            attributes: TextTableViewCell.blackTextAttributes,
            for: word.wordEntry
        )
        
        PosToken.highlightPosTokensInTextView(textView: textView)
    }
    
    func make(sentence: Sentence) {
        var text = ""
        if sentence.isEnglishTranslated {
            text = sentence.greekSentence
        } else {
            text = sentence.englishSentence
        }
        textView.text = text
        
        textView.textStorage.set(
            attributes: TextTableViewCell.blackTextAttributes
        )
        
        // TODO: - Fix here.
        if text.count < 45 {  // For short sentences.
            textView.text += "\n"
        }
    }
}

extension TextTableViewCell {
    static let textViewInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    
    static let posAttributes: [NSAttributedString.Key: Any] = [
        .font: Theme.bodyFont,
        .backgroundColor : Theme.lightBlue
    ]
    static let grayTextAttributes: [NSAttributedString.Key: Any] = [
        .font : Theme.bodyFont,
        .foregroundColor : UIColor.gray
    ]
    static let blackTextAttributes: [NSAttributedString.Key: Any] = [
        .font : Theme.bodyFont,
        .foregroundColor : UIColor.black
    ]
}

protocol TextTableViewCellDelegate {
    func switchToLoopView(cellId: Int)
}
