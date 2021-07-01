//
//  UIEdgeInsetsLabel.swift
//  α
//
//  Created by Sola on 2021/6/25.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class EdgeInsetsLabel: UILabel {
    
    // MARK: - TODO: wrap the label in a content view instead.
    // the current solution does not take the numberOfLines into account.
    
    var top: CGFloat!
    var left: CGFloat!
    var bottom: CGFloat!
    var right: CGFloat!
    
    open override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = size.height + edgeInsets.top + edgeInsets.bottom
        size.width = size.width + edgeInsets.left + edgeInsets.right
        return size
    }
    
    // MARK: - Views
    
    var edgeInsets: UIEdgeInsets{
        return UIEdgeInsets(top: self.top, left: self.left, bottom: self.bottom, right: self.right)
    }
    
    // MARK: - Init
    
    init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        super.init(frame: CGRect())
        
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Drawing
    
    override func drawText(in rect: CGRect) {
        let r = rect.inset(by: edgeInsets)
        super.drawText(in: r)
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines n: Int) -> CGRect {
        let b = bounds
        let tr = b.inset(by: edgeInsets)
        let ctr = super.textRect(forBounds: tr, limitedToNumberOfLines: 0)
        return ctr
    }
}
