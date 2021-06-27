//
//  DetailedTextView.swift
//  α
//
//  Created by Sola on 2021/6/25.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class DetailedTextView: BaseTextView {
    
    // MARK: - Views
    
    lazy var wordLabel: UILabel = {
        let label = UILabel()
        mainView.addSubview(label)
        
        label.backgroundColor = mainView.backgroundColor
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: DetailedTextView.wordLabelFontSize)
        
        return label
    }()
    
    lazy var meaningLabel: EdgeInsetsLabel = {
        let label = EdgeInsetsLabel(
            top: DetailedTextView.labelInset,
            left: DetailedTextView.labelInset,
            bottom: DetailedTextView.labelInset,
            right: DetailedTextView.labelInset
        )
        mainView.addSubview(label)
        
        label.backgroundColor = .lightText
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: DetailedTextView.mearningLabelFontSize)
        label.sizeToFit()
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        
        return label
    }()
    
    lazy var explanationLabel: EdgeInsetsLabel = {
        let label = EdgeInsetsLabel(
            top: DetailedTextView.labelInset,
            left: DetailedTextView.labelInset,
            bottom: DetailedTextView.labelInset,
            right: DetailedTextView.labelInset
        )
        mainView.addSubview(label)
        
        label.backgroundColor = .lightText
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: DetailedTextView.explanationLabelFontSize)
        label.sizeToFit()
        label.layer.cornerRadius = 10
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
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        meaningLabel.snp.makeConstraints { (make) in
            make.top.equalTo(wordLabel.snp.bottom).offset(20)
            make.leading.equalTo(wordLabel.snp.leading)
            make.width.equalTo(wordLabel.snp.width)
        }
        
        explanationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(meaningLabel.snp.bottom).offset(20)
            make.leading.equalTo(wordLabel.snp.leading)
            make.width.equalTo(wordLabel.snp.width)
        }
    }
}

extension DetailedTextView {
    static let wordLabelFontSize = UIScreen.main.bounds.width * 0.09
    static let mearningLabelFontSize = UIScreen.main.bounds.width * 0.05
    static let explanationLabelFontSize = UIScreen.main.bounds.width * 0.04
    static let labelInset = UIScreen.main.bounds.width * 0.02
}
