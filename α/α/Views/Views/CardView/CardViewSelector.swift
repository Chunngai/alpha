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
        self.updateLayouts()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateViews() {
    }
    
    func updateLayouts() {
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
            displayDetailed(
                wordEntry: word.wordEntry,
                wordMeanings: word.wordMeanings,
                explanationString: word.explanation
            )
        }
    }
    
    func displaySentence(sentence: Sentence, isBrief: Bool) {
        let string = isBrief ? sentence.text : sentence.translation
        let shouldUnderline: Bool = !isBrief
        
        let attrString = NSMutableAttributedString(string: string)
        if shouldUnderline {
            attrString.setUnderline(color: .gray)
        }
        displaySingleLine(string: attrString)
    }
    
    func displaySingleLine(string: NSAttributedString) {
        singleLineCardView.isHidden = false
        detailedCardView.isHidden = true
        
        singleLineCardView.set(text: string)
    }
    
    func displayDetailed(wordEntry: String, wordMeanings: String, explanationString: String?) {
        detailedCardView.isHidden = false
        singleLineCardView.isHidden = true
        
        detailedCardView.set(
            wordEntry: wordEntry,
            wordMeanings: wordMeanings,
            explanationString: explanationString
        )
    }
}

protocol CardViewSelectorSingleLineDelegate {
    func set(text: NSAttributedString)
}

protocol CardViewSelectorDetailedDelegate {
    func set(wordEntry: String, wordMeanings: String, explanationString: String?)
}
