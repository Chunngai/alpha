//
//  TextTableViewCell.swift
//  α
//
//  Created by Sola on 2021/7/1.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
        
    // MARK: - Views
    
    lazy var textView: TextViewWithRoundCornersBackground = {
        let textStorage = NSTextStorage()

        let textLayoutManager = LayoutManagerForRoundedCornersBackground()
        textLayoutManager.cornerRadius = 5
        textStorage.addLayoutManager(textLayoutManager)
        
        let textContainer = NSTextContainer(size: self.contentView.bounds.size)
        textLayoutManager.addTextContainer(textContainer)
        
        // TODO: - Wrap the code above.
        
        let textView = TextViewWithRoundCornersBackground(frame: CGRect.zero, textContainer: textContainer)
        contentView.addSubview(textView)
        
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
        self.backgroundColor = .background
        
        textView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    func updateValues(word: Word? = nil, sentence: Sentence? = nil) {
        if let word = word {
            make(word: word)
        } else if let sentence = sentence {
            make(sentence: sentence)
        }
    }
    
    // MARK: - Utils
    
    func highlightPosTokens() {
        for pos in Word.posList {
            let posToken = Word.posAbbr[pos]!.indent(leftIndent: 1, rightIndent: 1)
            
            let range = textView.text.range(of: posToken)
            if range != nil {
                textView.textStorage.setAll(
                    attributes: TextTableViewCell.posAttributes,
                    for: posToken
                )
            }
        }
    }
    
    func make(word: Word) {
        var text = ""
        text += word.wordEntry
        text += "\n"
        text += word.wordMeaningsWithMarks
        textView.text = text
        
        textView.textStorage.set(
            attributes: TextTableViewCell.grayTextAttributes
        )
        textView.textStorage.set(
            attributes: TextTableViewCell.blackTextAttributes,
            for: word.wordEntry
        )
        
        highlightPosTokens()
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
    
//    static let wordEntryFont = UIFont.systemFont(ofSize: 17)
//    static let wordMeaningsFont = UIFont.systemFont(ofSize: 15)
    static let posAttributes: [NSAttributedString.Key: Any] = [
        .font: Theme.bodyFont,
        .backgroundColor : UIColor.lightBlue
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
