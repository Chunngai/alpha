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
    
    lazy var label: UILabel = {
        let label = UILabel()
        mainView.addSubview(label)
        
        label.backgroundColor = mainView.backgroundColor
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: SingleLineCardView.labelFontSize)
        
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
            make.width.equalToSuperview().multipliedBy(0.90)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension SingleLineCardView {
    static let labelFontSize = UIScreen.main.bounds.width * 0.06
}
