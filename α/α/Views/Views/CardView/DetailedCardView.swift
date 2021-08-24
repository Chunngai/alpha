//
//  DetailedTextView.swift
//  α
//
//  Created by Sola on 2021/6/25.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class DetailedCardView: BaseCardView {
    
    // MARK: - Views
    
    lazy var entryLabel: UILabel = {
        let label = UILabel()
        mainView.addSubview(label)
        
        label.backgroundColor = mainView.backgroundColor
        label.textColor = Theme.textColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = Theme.title1Font
        
        return label
    }()
    
    lazy var meaningsLabel: UILabel = {
        let label = UILabel()
        mainView.addSubview(label)

        label.backgroundColor = mainView.backgroundColor
        label.textColor = Theme.weakTextColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Meanings: "
        label.font = Theme.headlineFont

        return label
    }()
    
    lazy var meaningsContentTextView: RoundCornersBgTextView = {
        let textView = RoundCornersBgTextView(frame: CGRect.zero, textContainerSize: mainView.bounds.size)
        mainView.addSubview(textView)
        
        textView.backgroundColor = .lightText
        textView.textColor = Theme.textColor
        textView.textAlignment = .left
        textView.font = Theme.bodyFont
        textView.sizeToFit()
        textView.layer.cornerRadius = DetailedCardView.cornerRadius
        textView.layer.masksToBounds = true
        textView.isEditable = false
        // The statement below makes contentSize.height be 0.
        textView.isScrollEnabled = false  // Wo it the cell height is not accurate.
        textView.textContainerInset = DetailedCardView.textViewInset
        
        return textView
    }()
    
    lazy var explanationLabel: UILabel = {
        let label = UILabel()
        mainView.addSubview(label)
        
        label.backgroundColor = mainView.backgroundColor
        label.textColor = Theme.weakTextColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = Theme.headlineFont
        label.text = "Explanation: "
        
        return label
    }()
    
    lazy var explanationContentTextView: RoundCornersBgTextView = {
        let textView = RoundCornersBgTextView(
            frame: CGRect.zero,
            textContainerSize: mainView.bounds.size,
            shoudCenterVertically: false
        )
        mainView.addSubview(textView)
        
        textView.backgroundColor = .lightText
        textView.textColor = Theme.textColor
        textView.textAlignment = .left
        textView.font = Theme.bodyFont
        textView.sizeToFit()
        textView.layer.cornerRadius = DetailedCardView.cornerRadius
        textView.layer.masksToBounds = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = DetailedCardView.textViewInset
        textView.showsVerticalScrollIndicator = false
        
        return textView
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
    
    override func updateViews() {
        super.updateViews()
    }
    
    override func updateLayouts() {
        super.updateLayouts()
        
        entryLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        meaningsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(entryLabel.snp.bottom).offset(20)
            make.leading.equalTo(entryLabel.snp.leading)
            make.width.equalTo(entryLabel.snp.width)
        }
        
        meaningsContentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(meaningsLabel.snp.bottom).offset(10)
            make.leading.equalTo(entryLabel.snp.leading)
            make.width.equalTo(entryLabel.snp.width)
        }
        
        explanationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(meaningsContentTextView.snp.bottom).offset(20)
            make.leading.equalTo(entryLabel.snp.leading)
            make.width.equalTo(entryLabel.snp.width)
        }
        
        explanationContentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(explanationLabel.snp.bottom).offset(10)
            make.leading.equalTo(entryLabel.snp.leading)
            make.width.equalTo(entryLabel.snp.width)
            // The bottom constraint is important to determine
            // the content size of the scrollview.
            // https://blog.csdn.net/longshihua/article/details/78441466
            make.bottom.equalToSuperview().inset(30)
        }
    }
}

extension DetailedCardView: CardViewSelectorDetailedDelegate {
    // MARK: - CardViewSelectorDetailedDelegate
    
    func set(wordEntry: String, wordMeanings: String, explanationString: String?) {
        entryLabel.text = wordEntry
        meaningsContentTextView.text = wordMeanings
        if let explanationString = explanationString {
            explanationLabel.isHidden = false
            explanationContentTextView.isHidden = false
            explanationContentTextView.text = explanationString
        } else {
            explanationLabel.isHidden = true
            explanationContentTextView.isHidden = true
            explanationContentTextView.text = ""
        }
        Token.highlightTokens(in: meaningsContentTextView)
        
        scrollView.scrollToTop(animated: false)
    }
}

extension DetailedCardView {
    static let textViewInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
}
