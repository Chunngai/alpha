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
    
    // MARK: - Utils
    
    func displayWord(word: Word, isBrief: Bool) {
        if isBrief {
            displaySingleLine(string: word.wordEntry)
        } else {
            displayDetailed(greekString: word.wordEntry, englishString: word.wordMeanings, explanationString: word.explanation)
        }
    }
    
    func displaySentence(sentence: Sentence, isBrief: Bool) {
        if sentence.isEnglishTranslated {
            displaySingleLine(string: isBrief ? sentence.greekSentence : sentence.englishSentence)
        } else if sentence.isGreekTranslated {
            displaySingleLine(string: isBrief ? sentence.englishSentence : sentence.greekSentence)
        }
    }
    
    func displaySingleLine(string: String) {
        singleLineCardView.isHidden = false
        detailedCardView.isHidden = true
        
        singleLineCardView.label.text = string
    }
    
    func displayDetailed(greekString: String, englishString: String, explanationString: String?) {
        detailedCardView.isHidden = false
        singleLineCardView.isHidden = true
        
        detailedCardView.wordLabel.text = greekString
        detailedCardView.meaningsContentLabel.text = englishString
        if let explanationString = explanationString {
            detailedCardView.explanationLabel.isHidden = false
            detailedCardView.explanationContentLabel.isHidden = false
            detailedCardView.explanationContentLabel.text = explanationString
        } else {
            detailedCardView.explanationLabel.isHidden = true
            detailedCardView.explanationContentLabel.isHidden = true
        }
    }
}
