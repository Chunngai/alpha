//
//  SingleLineTextView.swift
//  α
//
//  Created by Sola on 2021/6/25.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class SingleLineCardView: BaseCardView {
    
    // MARK: - Views
    
    lazy var label: PaddingLabel = {
        let label = PaddingLabel(padding: SingleLineCardView.labelPadding)
        mainView.addSubview(label)

        label.backgroundColor = mainView.backgroundColor
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(
            string: " ",
            attributes: SingleLineCardView.labelAttributes
        )
        
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
        
        label.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension SingleLineCardView {
    static let labelPadding = 20
    static let labelAttributes: [NSAttributedString.Key: Any] = [
        .paragraphStyle: {
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = 5
            paragraph.alignment = .center
            paragraph.lineBreakMode = .byWordWrapping
            return paragraph
        }(),
        .font: UIFont.systemFont(ofSize: 25),
        .foregroundColor: UIColor.black
    ]
}
