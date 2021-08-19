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
        let lineHeight: CGFloat = UnderLineTextField.lineHeight
        let lineColor = UIColor.gray.cgColor
        
        guard let content = UIGraphicsGetCurrentContext() else { return }
        content.setFillColor(lineColor)
        content.fill(CGRect(
            x: 0,
            y: self.frame.height - lineHeight,
            width: self.frame.width,
            height: lineHeight
        ))
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
    }
}

extension UnderLineTextField {
    static let lineHeight: CGFloat = 0.5
}
