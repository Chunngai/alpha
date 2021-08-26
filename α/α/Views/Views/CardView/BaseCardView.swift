//
//  TextsView.swift
//  α
//
//  Created by Sola on 2021/1/22.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class BaseCardView: UIView {
    
    // MARK: - Views
    
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        addSubview(scrollView)
        
        scrollView.backgroundColor = Theme.lightBlue
        scrollView.layer.cornerRadius = BaseCardView.cornerRadius
        scrollView.layer.masksToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    lazy var mainView: UIView = {
        let mainView = UIView()
        scrollView.addSubview(mainView)
        
        mainView.backgroundColor = Theme.lightBlue
        
        return mainView
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
    
    func updateViews() {
    }
    
    func updateLayouts() {
        scrollView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.90)
            make.width.equalToSuperview().multipliedBy(0.90)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        mainView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

extension BaseCardView {
    static let cornerRadius: CGFloat = 10
}
