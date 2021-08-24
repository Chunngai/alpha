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
        label.backgroundColor = mainView.backgroundColor
        label.textColor = Theme.textColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = Theme.title1Font
        return label
    }()
    
    lazy var meaningsLabel: UILabel = {
        let label = UILabel()
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
    
    lazy var sentencesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = mainView.backgroundColor
        label.textColor = Theme.weakTextColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Sentences: "
        label.font = Theme.headlineFont
        return label
    }()
    
    lazy var sentencesContentTextView: RoundCornersBgTextView = {
        let textView = RoundCornersBgTextView(
            frame: CGRect.zero,
            textContainerSize: mainView.bounds.size,
            shoudCenterVertically: false
        )
        textView.backgroundColor = .lightText
        textView.sizeToFit()
        textView.layer.cornerRadius = DetailedCardView.cornerRadius
        textView.layer.masksToBounds = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = DetailedCardView.textViewInset
        textView.showsVerticalScrollIndicator = false
        textView.attributedText = NSAttributedString(
            string: " ",
            attributes: DetailedCardView.textViewAttrs
        )
        return textView
    }()
    
    lazy var viewStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            entryLabel,
            meaningsLabel,
            meaningsContentTextView,
            explanationLabel,
            explanationContentTextView,
            sentencesLabel,
            sentencesContentTextView
        ])
        stack.axis = .vertical
        stack.setCustomSpacing(DetailedCardView.spacingAfterEntryLabel, after: entryLabel)
        stack.setCustomSpacing(DetailedCardView.spacingAfterMeaningsLabel, after: meaningsLabel)
        stack.setCustomSpacing(DetailedCardView.spacingAfterMeaningsContentTextView, after: meaningsContentTextView)
        stack.setCustomSpacing(DetailedCardView.spacingAfterExplanationLabel, after: explanationLabel)
        stack.setCustomSpacing(DetailedCardView.spacingAfterExplanationContentTextView, after: explanationContentTextView)
        stack.setCustomSpacing(DetailedCardView.spacingAfterSentencesLabel, after: sentencesLabel)
        stack.setCustomSpacing(DetailedCardView.spacingAfterSentencesContentTextView, after: sentencesContentTextView)
        return stack
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
        
        mainView.addSubview(viewStack)
    }
    
    override func updateLayouts() {
        super.updateLayouts()
        
        viewStack.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.width.equalToSuperview()
            // The bottom constraint is important to determine
            // the content size of the scrollview.
            // https://blog.csdn.net/longshihua/article/details/78441466
            make.bottom.equalToSuperview().inset(30)
        }
    }
}

extension DetailedCardView: CardViewSelectorDetailedDelegate {
    // MARK: - CardViewSelectorDetailedDelegate
    
    func set(wordEntry: String, wordMeanings: String, wordExplanation: String, wordSentences: String) {
        entryLabel.text = wordEntry
        
        meaningsContentTextView.text = wordMeanings
        Token.highlightTokens(in: meaningsContentTextView)

        if !wordExplanation.isEmpty {
            explanationLabel.isHidden = false
            explanationContentTextView.isHidden = false
            explanationContentTextView.text = wordExplanation
        } else {
            explanationLabel.isHidden = true
            explanationContentTextView.isHidden = true
            explanationContentTextView.text = ""
        }
        
        if !wordSentences.isEmpty {
            sentencesLabel.isHidden = false
            sentencesContentTextView.isHidden = false
            sentencesContentTextView.text = wordSentences
        } else {
            sentencesLabel.isHidden = true
            sentencesContentTextView.isHidden = true
            sentencesContentTextView.text = ""
        }
        
        scrollView.scrollToTop(animated: false)
        updateLayouts()
    }
}

extension DetailedCardView {
    static let textViewInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    static let textViewAttrs: [NSAttributedString.Key: Any] = [
        .paragraphStyle: Theme.paraStyle,
        .font: Theme.bodyFont,
        .foregroundColor: UIColor.black
    ]
    
    static let spacingAfterEntryLabel: CGFloat = 20
    static let spacingAfterMeaningsLabel : CGFloat = 10
    static let spacingAfterMeaningsContentTextView : CGFloat = 20
    static let spacingAfterExplanationLabel : CGFloat = 10
    static let spacingAfterExplanationContentTextView : CGFloat = 20
    static let spacingAfterSentencesLabel : CGFloat = 10
    static let spacingAfterSentencesContentTextView : CGFloat = 20
}
