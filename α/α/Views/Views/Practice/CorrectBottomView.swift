//
//  CorrectButtonView.swift
//  α
//
//  Created by Sola on 2021/10/8.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class CorrectBottomView: BottomView {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateViews()
        updateLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateViews() {
        super.updateViews()
        
        backgroundColor = UIColor.hexRGB2UIColor("#D6FFB8")
        
        label.textColor = UIColor.hexRGB2UIColor("#58A700")
        label.text = "Excellent!"
    }
}
