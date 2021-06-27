//
//  TextsView.swift
//  α
//
//  Created by Sola on 2021/1/22.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class BaseTextView: UIView {
    
    // MARK: - Views
    
    lazy var mainView: UIView = {
        let mainView = UIView()
        addSubview(mainView)
        
        mainView.backgroundColor = .lightBlue
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        
        return mainView
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
        mainView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.90)
            make.width.equalToSuperview().multipliedBy(0.90)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
