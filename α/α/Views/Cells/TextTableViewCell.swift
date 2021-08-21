//
//  TextTableViewCell.swift
//  α
//
//  Created by Sola on 2021/7/1.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell, TextViewControllerDelegate {
        
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
        textView.textContainerInset = TextTableViewCell.textViewInsets
        
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
    // MARK: - TextViewController Delegate
    
    func attractAttention() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.3,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: {
                UIView.modifyAnimations(withRepeatCount: 2, autoreverses: true, animations: {
                    self.textView.backgroundColor = Theme.lightBlue
                })
        }) { _ in
            self.textView.backgroundColor = .white
        }
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
            attributes: TextTableViewCell.wordEntryAttributes,
            for: word.wordEntry
        )
        textView.textStorage.set(
            attributes: TextTableViewCell.wordMeaningsAttributes,
            for: word.wordMeanings
        )
        
        PosToken.highlightPosTokensInTextView(textView: textView)
    }
    
    func make(sentence: Sentence) {
        var sentTextLangToken = ""
        var sentTranslationLangToken = ""
        var sentText = ""
        var sentTranslation = ""
        if sentence.isEnglishTranslated {
            sentTextLangToken = TextTableViewCell.greekLangToken
            sentText = sentence.greekSentence
            sentTranslationLangToken = TextTableViewCell.englishLangToken
            sentTranslation = sentence.englishSentence
        } else {
            sentTextLangToken = TextTableViewCell.englishLangToken
            sentText = sentence.englishSentence
            sentTranslationLangToken = TextTableViewCell.greekLangToken
            sentTranslation = sentence.greekSentence
        }
        
        var text = ""
        text.append(sentTextLangToken)
        text.append(" ")
        text.append(sentText)
        text.append("\n")
        text.append(sentTranslationLangToken)
        text.append(" ")
        text.append(sentTranslation)
        
        textView.text = text
        textView.textStorage.set(
            attributes: TextTableViewCell.greekLangTokenAttrs,
            for: TextTableViewCell.greekLangToken
        )
        textView.textStorage.set(
            attributes: TextTableViewCell.englishLangTokenAttrs,
            for: TextTableViewCell.englishLangToken
        )
        textView.textStorage.set(
            attributes: TextTableViewCell.sentenceTextAttributes,
            for: sentText
        )
        textView.textStorage.set(
            attributes: TextTableViewCell.sentenceTranslationAttributes,
            for: sentTranslation
        )
    }
}

extension TextTableViewCell {
    static let textViewInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    
    static let greekLangToken = " el  "
    static let englishLangToken = " en "
    
    static let commonTextAttrs: [NSAttributedString.Key: Any] = [
        .paragraphStyle: Theme.paraStyle,
        .font: Theme.bodyFont,
    ]
    
    static let wordEntryAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: Theme.textColor]
        .mergingByKeepingOwnKeys(TextTableViewCell.commonTextAttrs)
    static let wordMeaningsAttributes: [NSAttributedString.Key: Any] = [.foregroundColor : Theme.weakTextColor]
        .mergingByKeepingOwnKeys(TextTableViewCell.commonTextAttrs)
    
    static let greekLangTokenAttrs: [NSAttributedString.Key: Any] = [.backgroundColor: Theme.elColor]
        .mergingByKeepingOwnKeys(TextTableViewCell.commonTextAttrs)
    static let englishLangTokenAttrs: [NSAttributedString.Key: Any] = [.backgroundColor: Theme.enColor]
        .mergingByKeepingOwnKeys(TextTableViewCell.commonTextAttrs)
    
    static let sentenceTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: Theme.textColor]
        .mergingByKeepingOwnKeys(TextTableViewCell.commonTextAttrs)
    static let sentenceTranslationAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: Theme.weakTextColor]
        .mergingByKeepingOwnKeys(TextTableViewCell.commonTextAttrs)
}

protocol TextTableViewCellDelegate {
    func switchToLoopView(cellId: Int)
}
