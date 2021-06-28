//
//  UnderlineTextField.swift
//  α
//
//  Created by Sola on 2021/6/28.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class UnderLineTextField: UITextField {
    override func draw(_ rect: CGRect) {
        let lineHeight: CGFloat = 0.5
        let lineColor = UIColor.gray
        
        guard let content = UIGraphicsGetCurrentContext() else { return }
        content.setFillColor(lineColor.cgColor)
        content.fill(CGRect(
            x: 0,
            y: self.frame.height - lineHeight,
            width: self.frame.width,
            height: lineHeight
        ))
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
    }
}
