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
    
    lazy var wordLabel: UILabel = {
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
        textView.contentInset = DetailedCardView.textViewInsets
        
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
    
    lazy var explanationContentLabel: PaddingLabel = {
        let label = PaddingLabel(padding: DetailedCardView.labelInset)
        mainView.addSubview(label)
        
        label.backgroundColor = .lightText
        label.textColor = Theme.textColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = Theme.bodyFont
        label.sizeToFit()
        label.layer.cornerRadius = DetailedCardView.cornerRadius
        label.layer.masksToBounds = true
        
        return label
    }()

    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.updateViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateViews() {
        super.updateViews()
        
        wordLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(25)
        }
        
        meaningsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(wordLabel.snp.bottom).offset(20)
            make.leading.equalTo(wordLabel.snp.leading)
            make.width.equalTo(wordLabel.snp.width)
        }
        
        meaningsContentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(meaningsLabel.snp.bottom).offset(10)
            make.leading.equalTo(wordLabel.snp.leading)
            make.width.equalTo(wordLabel.snp.width)
        }
        
        explanationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(meaningsContentTextView.snp.bottom).offset(20)
            make.leading.equalTo(wordLabel.snp.leading)
            make.width.equalTo(wordLabel.snp.width)
        }
        
        explanationContentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(explanationLabel.snp.bottom).offset(10)
            make.leading.equalTo(wordLabel.snp.leading)
            make.width.equalTo(wordLabel.snp.width)
        }
    }
}

extension DetailedCardView {
    // MARK: - Utils
    
    func highlightPosTokens() {
        for pos in Word.posList {
            let posToken = Word.posAbbr[pos]!.indent(leftIndent: 1, rightIndent: 1)
            
            let range = meaningsContentTextView.text.range(of: posToken)
            if range != nil {
                meaningsContentTextView.textStorage.set(
                    attributes: TextTableViewCell.posAttributes,
                    forAll: posToken
                )
            }
        }
    }
}

extension DetailedCardView {
    static let textBackgroundCornerRadius: CGFloat = 5
    static let labelInset = 10
    static let textViewInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
}
