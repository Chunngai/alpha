//
//  TextsView.swift
//  α
//
//  Created by Sola on 2021/1/22.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextView: UIView {

    // MARK: - Views
    
    lazy var label: UILabel = {
        let label = UILabel()
        addSubview(label)
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: TextView.fontSize)
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
    
    func updateViews() {
        label.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }
    }
}

extension TextView {
    static let fontSize = UIScreen.main.bounds.width * 0.06
}
