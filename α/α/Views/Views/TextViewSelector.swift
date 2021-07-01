//
//  TextViewSelector.swift
//  α
//
//  Created by Sola on 2021/6/26.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextViewSelector: UIView {

    // MARK: - Views
    
    lazy var singleLineTextView: SingleLineTextView = {
        let textView = SingleLineTextView()
        addSubview(textView)
        return textView
    }()
    
    lazy var detailedTextView: DetailedTextView = {
        let textView = DetailedTextView()
        addSubview(textView)
        return textView
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
        singleLineTextView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        detailedTextView.snp.makeConstraints { (make) in
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
        displaySingleLine(string: isBrief ? sentence.greekSentence: sentence.englishSentence)
    }
    
    func displaySingleLine(string: String) {
        singleLineTextView.isHidden = false
        detailedTextView.isHidden = true
        
        singleLineTextView.label.text = string
    }
    
    func displayDetailed(greekString: String, englishString: String, explanationString: String?) {
        detailedTextView.isHidden = false
        singleLineTextView.isHidden = true
        
        detailedTextView.wordLabel.text = greekString
        detailedTextView.meaningContentLabel.text = englishString
        if let explanationString = explanationString {
            detailedTextView.explanationLabel.isHidden = false
            detailedTextView.explanationContentLabel.isHidden = false
            detailedTextView.explanationContentLabel.text = explanationString
        } else {
            detailedTextView.explanationLabel.isHidden = true
            detailedTextView.explanationContentLabel.isHidden = true
        }
    }
}
