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
    
    let fadeTransition: CATransition = {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.duration = 0.6
        return transition
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        addSubview(label)
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
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
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.95)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension TextView {
    static let fontSize = UIScreen.main.bounds.width * 0.06
}
