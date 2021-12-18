//
//  ButtomView.swift
//  α
//
//  Created by Sola on 2021/10/9.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class BottomView: UIView {

    lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Arial Rounded MT Bold", size: Theme.title2Font.pointSize)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateViews()
        updateLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateViews() {
        addSubview(label)
    }
    
    func updateLayouts() {
        label.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(15)
        }
    }
}

extension BottomView {
    func floatUp(by offset: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
            self.frame = CGRect(
                x: self.frame.minX,
                y: self.frame.minY - offset,
                width: self.frame.width,
                height: self.frame.height
            )
            self.layoutIfNeeded()
        })
    }
    
    func floatDown(by offset: CGFloat) {
        frame = CGRect(
            x: frame.minX,
            y: frame.minY + offset,
            width: frame.width,
            height: frame.height
        )
        layoutIfNeeded()
    }
}
