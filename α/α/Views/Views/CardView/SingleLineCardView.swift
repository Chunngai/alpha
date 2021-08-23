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
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = Theme.title1Font
        
        return label
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
        
        label.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension SingleLineCardView: CardViewSelectorSingleLineDelegate {
    // MARK: - CardViewSelector delegate
    
    func set(text: NSAttributedString) {
        label.attributedText = text
    }
}

extension SingleLineCardView {
    static let labelPadding = 20
}
