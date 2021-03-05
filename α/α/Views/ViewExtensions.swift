//
//  ViewExtensions.swift
//  α
//
//  Created by Sola on 2021/1/16.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let lightBlue = UIColor(
        red: CGFloat(210) / 255,
        green: CGFloat(239) / 255,
        blue: CGFloat(255) / 255,
        alpha: 1
    )
}

extension UIImage {
    func resize(to targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        return resize(widthRatio: widthRatio, heightRatio: heightRatio)
    }
    
    func resize(widthRatio: CGFloat, heightRatio: CGFloat) -> UIImage {
        let newSize = widthRatio > heightRatio
            ? CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            : CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func scale(to ratio: CGFloat) -> UIImage {
        return resize(widthRatio: ratio, heightRatio: ratio)
    }
}


class UIEdgeInsetsLabel: UILabel {
    
    var top: CGFloat!
    var left: CGFloat!
    var bottom: CGFloat!
    var right: CGFloat!
    
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
    
    var UIEI: UIEdgeInsets{
        return UIEdgeInsets(top: self.top, left: self.left, bottom: self.bottom, right: self.right)
    }
    
    open override var intrinsicContentSize: CGSize {
        numberOfLines = 0
        var s = super.intrinsicContentSize
        s.height = s.height + UIEI.top + UIEI.bottom
        s.width = s.width + UIEI.left + UIEI.right
        return s
    }
    
    override func drawText(in rect: CGRect) {
        let r = rect.inset(by: UIEI)
        super.drawText(in: r)
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines n: Int) -> CGRect {
        let b = bounds
        let tr = b.inset(by: UIEI)
        let ctr = super.textRect(forBounds: tr, limitedToNumberOfLines: 0)
        return ctr
    }
}
