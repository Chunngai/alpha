//
//  NSAttributedStringExtension.swift
//  α
//
//  Created by Sola on 2021/8/19.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func set(attributes: [NSAttributedString.Key: Any], for textToFind: String? = nil, compareOptions: String.CompareOptions = String.caseAndDiacriticInsensitiveCompareOptions) {
        let range: NSRange?
        if let textToFind = textToFind {
            range = self.mutableString.range(of: textToFind, options: compareOptions)
        } else {
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttributes(attributes, range: range!)
        }
    }
    
    func set(attributes: [NSAttributedString.Key: Any], forAll textToFind: String, compareOptions: String.CompareOptions = String.caseAndDiacriticInsensitiveCompareOptions) {
        var range = NSRange(location: 0, length: self.length)
        while (range.location != NSNotFound) {
            range = (self.string as NSString).range(of: textToFind, options: compareOptions, range: range)
            if (range.location != NSNotFound) {
                self.addAttributes(attributes, range: NSRange(location: range.location, length: textToFind.count))
                range = NSRange(location: range.location + range.length, length: self.string.count - (range.location + range.length))
            }
        }
    }
    
    func setBackgroundColor(for textToFind: String? = nil, color: UIColor, compareOptions: String.CompareOptions = String.caseAndDiacriticInsensitiveCompareOptions) {
        set(attributes: [.backgroundColor : color], for: textToFind, compareOptions: compareOptions)
    }
    
    func setTextColor(for textToFind: String? = nil, color: UIColor, compareOptions: String.CompareOptions = String.caseAndDiacriticInsensitiveCompareOptions) {
        set(attributes: [NSAttributedString.Key.foregroundColor : color], for: textToFind, compareOptions: compareOptions)
    }
    
    func setUnderline(for textToFind: String? = nil, color: UIColor = .black, style: NSUnderlineStyle = NSUnderlineStyle.single, compareOptions: String.CompareOptions = String.caseAndDiacriticInsensitiveCompareOptions) {
        set(
            attributes: [
                .underlineColor: color,
                .underlineStyle: style.rawValue,
            ],
            for: textToFind,
            compareOptions: compareOptions
        )
    }
    
    func setUnderline(forAll textToFind: String? = nil, color: UIColor = .black, style: NSUnderlineStyle = NSUnderlineStyle.single, compareOptions: String.CompareOptions = String.caseAndDiacriticInsensitiveCompareOptions) {
        set(
            attributes: [
                .underlineColor: color,
                .underlineStyle: style.rawValue,
            ],
            forAll: textToFind!,
            compareOptions: compareOptions
        )
    }
}

extension Sequence where Iterator.Element: NSAttributedString {
    func joined(with separator: NSAttributedString, ignoring charactersToIgnore: String = "") -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else if !charactersToIgnore.contains(e.string) {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(with separator: String, ignoring charactersToIgnore: String = "") -> NSAttributedString {
        return joined(with: NSAttributedString(string: separator), ignoring: charactersToIgnore)
    }
}

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    func mergingByKeepingOwnKeys(_ other: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any] {
        return self.merging(other) { (a, b) -> Value in a }
    }
}
