//
//  FunctionButtonView.swift
//  α
//
//  Created by Sola on 2021/1/22.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class FunctionButtonView: UIView {

    // MARK: - Views
    
    lazy var button: UIButton = {
        let button = UIButton()
        addSubview(button)
        button.setTitle("Learning", for: .normal)
        button.setTitleColor(FunctionButtonView.buttonTitleColor, for: .normal)
        button.backgroundColor = FunctionButtonView.buttonBackgroungColor
        button.layer.cornerRadius = FunctionButtonView.buttonLayerCornerRadius
        return button
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
        button.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.98)
            make.width.equalToSuperview().multipliedBy(0.98)
            make.centerX.equalToSuperview()
        }
    }

    func updateValues(title: String) {
        button.setTitle(title, for: .normal)
    }
    
}

extension FunctionButtonView {
    static let buttonTitleColor: UIColor = .white
    static let buttonBackgroungColor: UIColor = .black
    static let buttonLayerCornerRadius: CGFloat = 10
}
