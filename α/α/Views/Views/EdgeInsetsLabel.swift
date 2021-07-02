//
//  UIEdgeInsetsLabel.swift
//  α
//
//  Created by Sola on 2021/6/25.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class EdgeInsetsLabel: UILabel {
    
    // MARK: - TODO: the current solution does not take the numberOfLines into account.
    
    var edgeInsets: UIEdgeInsets!
    
    override var intrinsicContentSize: CGSize {
        numberOfLines = 0
        
        var size = super.intrinsicContentSize
        size.height = size.height + edgeInsets.top + edgeInsets.bottom
        size.width = size.width + edgeInsets.left + edgeInsets.right
        return size
    }
    
    // MARK: - Init
    
    init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        super.init(frame: CGRect())
        
        edgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Drawing
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines n: Int) -> CGRect {
        return super.textRect(
            forBounds: bounds.inset(by: edgeInsets),
            limitedToNumberOfLines: 0
        )
    }
}
