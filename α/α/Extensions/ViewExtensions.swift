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
    static func intRGB2UIColor(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) -> UIColor {
        return UIColor(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: alpha
        )
    }
}

extension UIColor {
    static let lightBlue = intRGB2UIColor(red: 210, green: 239, blue: 255)
    static let lightBlueForIcon = intRGB2UIColor(red: 190, green: 219, blue: 235)
    static let background = UIColor.systemGray6
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

extension UIImage {
    func setColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        
        color.setFill()
        
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return coloredImage!
    }
}

extension NSMutableAttributedString {
    func set(attributes: [NSAttributedString.Key: Any], for textToFind: String? = nil) {
        let range: NSRange?
        if let textToFind = textToFind {
            range = self.mutableString.range(of: textToFind, options: String.caseAndDiacriticInsensitiveCompareOptions)
        } else {
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttributes(attributes, range: range!)
        }
    }
    
    func setAll(attributes: [NSAttributedString.Key: Any], for textToFind: String) {
        var range = NSRange(location: 0, length: self.length)
        while (range.location != NSNotFound) {
            range = (self.string as NSString).range(of: textToFind, options: [], range: range)
            if (range.location != NSNotFound) {
                self.addAttributes(attributes, range: NSRange(location: range.location, length: textToFind.count))
                range = NSRange(location: range.location + range.length, length: self.string.count - (range.location + range.length))
            }
        }
    }
    
    func setUnderline(for textToFind: String? = nil, color: UIColor = .black, style: NSUnderlineStyle = .single) {
        set(
            attributes: [
                .underlineStyle : style.rawValue,
                .underlineColor: color
            ],
            for: textToFind
        )
    }
    
    func setBackgroundColor(for textToFind: String? = nil, color: UIColor) {
        set(attributes: [.backgroundColor : color], for: textToFind)
    }
    
    func setBold(for textToFind: String? = nil, fontSize: CGFloat) {
        set(attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fontSize)], for: textToFind)
    }
    
    func setTextColor(for textToFind: String? = nil, color: UIColor) {
        set(attributes: [NSAttributedString.Key.foregroundColor : color], for: textToFind)
    }
}

extension UISearchBar {
    var isEmpty: Bool {
        if let keyWords = text {
            return keyWords.trimmingCharacters(in: CharacterSet(charactersIn: " ")).count == 0
        } else {
            return true
        }
    }
}
