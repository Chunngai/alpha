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

extension NSMutableAttributedString {
    func set(attributes: [NSAttributedString.Key: Any], with color: UIColor, for textToFind: String? = nil) {
        let range: NSRange?
        if let text = textToFind {
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        } else {
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttributes(attributes, range: range!)
        }
    }
    
    func setUnderline(with color: UIColor, for textToFind: String? = nil) {
        set(
            attributes: [
                .underlineStyle : NSUnderlineStyle.thick.rawValue,
                .underlineColor: color
            ],
            with: color,
            for: textToFind
        )
    }
    
    func setHightlight(with color: UIColor, for textToFind: String? = nil) {
        set(attributes: [.backgroundColor : color], with: color, for: textToFind)
    }
}
