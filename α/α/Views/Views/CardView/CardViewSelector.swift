//
//  TextViewSelector.swift
//  α
//
//  Created by Sola on 2021/6/26.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class CardViewSelector: UIView {

    // MARK: - Views
    
    lazy var singleLineCardView: SingleLineCardView = {
        let cardView = SingleLineCardView()
        addSubview(cardView)
        return cardView
    }()
    
    lazy var detailedCardView: DetailedCardView = {
        let cardView = DetailedCardView()
        addSubview(cardView)
        return cardView
    }()

    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.updateViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateViews() {
        singleLineCardView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        detailedCardView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
 
extension CardViewSelector {
    // MARK: - Functions
    
    func displayWord(word: Word, isBrief: Bool) {
        if isBrief {
            displaySingleLine(string: NSAttributedString(string: word.wordEntry))
        } else {
            displayDetailed(wordEntry: word.wordEntry, wordMeanings: word.wordMeanings, explanationString: word.explanation)
        }
    }
    
    func displaySentence(sentence: Sentence, isBrief: Bool) {
        var string = ""
        var shouldUnderline: Bool = false
        if sentence.isEnglishTranslated {
            if isBrief {
                string = sentence.greekSentence
            } else {
                string = sentence.englishSentence
                shouldUnderline = true
            }
        } else if sentence.isGreekTranslated {
            if isBrief {
                string = sentence.englishSentence
            } else {
                string = sentence.greekSentence
                shouldUnderline = true
            }
        }
        let attrString = NSMutableAttributedString(string: string)
        if shouldUnderline {
            attrString.setUnderline(color: .gray)
        }
        displaySingleLine(string: attrString)
    }
    
    func displaySingleLine(string: NSAttributedString) {
        singleLineCardView.isHidden = false
        detailedCardView.isHidden = true
        
        singleLineCardView.label.attributedText = string
    }
    
    func displayDetailed(wordEntry: String, wordMeanings: String, explanationString: String?) {
        detailedCardView.isHidden = false
        singleLineCardView.isHidden = true
        
        detailedCardView.wordLabel.text = wordEntry
        detailedCardView.meaningsContentTextView.text = wordMeanings
        if let explanationString = explanationString {
            detailedCardView.explanationLabel.isHidden = false
            detailedCardView.explanationContentTextView.isHidden = false
            detailedCardView.explanationContentTextView.text = explanationString
        } else {
            detailedCardView.explanationLabel.isHidden = true
            detailedCardView.explanationContentTextView.isHidden = true
        }
        detailedCardView.explanationContentTextView.scrollToTop(animated: false)
        
        Token.highlightTokens(in: detailedCardView.meaningsContentTextView)
    }
}
