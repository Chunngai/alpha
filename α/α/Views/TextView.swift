//
//  TextsView.swift
//  α
//
//  Created by Sola on 2021/1/22.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextView: UIView {

    var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: TMP.fontSize)
                
        return label
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }
    }
}
