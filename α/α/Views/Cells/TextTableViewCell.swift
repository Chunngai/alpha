//
//  TextTableViewCell.swift
//  α
//
//  Created by Sola on 2021/7/1.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
           
    var isVocab: Bool!
    var isBrief: Bool!
    
    // MARK: - Models
    
    var wordOrSentence: WordOrSentence!

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
        updateLayouts()
    }
    
    func updateViews() {
        self.selectionStyle = .none
        self.backgroundColor = Theme.backgroundColor
    }
    
    func updateLayouts() {
        textView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func updateValues(
        wordOrSentence: WordOrSentence,
        contentType: Lesson.ContentType,
        delegate: TextViewController,
        isBrief: Bool,
        textToHighlight: String?
    ) {
        self.wordOrSentence = wordOrSentence
        self.isVocab = contentType == .vocab
        self.delegate = delegate
        self.isBrief = isBrief
        
        if isVocab {
            make(word: wordOrSentence as! Word)
        } else {
            make(sentence: wordOrSentence as! Sentence)
        }
        
        if let textToHighlight = textToHighlight?.trimmingWhitespacesAndNewlines(),
            !textToHighlight.isEmpty {
            highlight(textToHighlight)
        }
    }
}

extension TextTableViewCell {
    // MARK: - Actions
    
    @objc func textViewTapped() {
        delegate.switchToLoopView(for: wordOrSentence)
    }
}
 
extension TextTableViewCell {
    // MARK: - Utils
    
    func make(word: Word) {
        textView.text = isBrief ?
            word.briefContent :
            word.detailedContent
        textView.textStorage.set(
            attributes: TextTableViewCell.wordEntryAttributes,
            for: word.wordEntry
        )
        textView.textStorage.set(
            attributes: TextTableViewCell.wordMeaningsAttributes,
            for: word.wordMeanings
        )
        AttributeToken.highlightAttributeTokens(in: textView)
    }
    
    func make(sentence: Sentence) {
        textView.text = isBrief ?
            sentence.briefContent :
            sentence.content
        textView.textStorage.set(
            attributes: TextTableViewCell.greekLangTokenAttrs,
            for: Sentence.greekLangToken
        )
        textView.textStorage.set(
            attributes: TextTableViewCell.englishLangTokenAttrs,
            for: Sentence.englishLangToken
        )
        textView.textStorage.set(
            attributes: TextTableViewCell.sentenceTextAttributes,
            for: sentence.text
        )
        textView.textStorage.set(
            attributes: TextTableViewCell.sentenceTranslationAttributes,
            for: sentence.translation
        )
    }
    
    func highlight(_ textToHighlight: String) {
        textView.textStorage.setTextColor(
            for: textToHighlight,
            color: Theme.highlightedTextColor
        )
    }
}

extension TextTableViewCell: TextViewControllerCellDelegate {
    // MARK: - TextViewController Cell Delegate
    
    func attractAttention() {
        
//        UIView.animate(
//            withDuration: 0.3,
//            delay: 0.3,
//            options: [.curveEaseInOut, .autoreverse, .repeat],
//            animations: {
//                UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true, animations: {
//                    self.textView.backgroundColor = Theme.lightBlue
//                })
//        }) {
//            _ in
//            self.textView.backgroundColor = .white
//        }
        
//        textView.backgroundColor = Theme.lightBlue
//        UIView.animate(
//            withDuration: 0.3,
//            delay: 0.3,
//            options: [.curveEaseInOut, .autoreverse, .repeat],
//            animations: {
//                UIView.modifyAnimations(withRepeatCount: 2, autoreverses: true, animations: {
//                    self.textView.backgroundColor = .white
//                })
//        })
        
        let propertyAnimator = UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.3,
            delay: 0.3,
            options: [.curveEaseInOut, .autoreverse],
            animations: {
                UIView.setAnimationRepeatCount(2)
                UIView.setAnimationRepeatAutoreverses(true)
                self.textView.backgroundColor = Theme.lightBlue
        }) { _ in
            self.textView.backgroundColor = .white
        }
        propertyAnimator.startAnimation()
    }
}

extension TextTableViewCell {
    static let textViewInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    
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
    func switchToLoopView(for wordOrSentence: WordOrSentence)
}
