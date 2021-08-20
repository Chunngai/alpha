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
    
    func set(attributes: [NSAttributedString.Key: Any], forAll textToFind: String) {
        var range = NSRange(location: 0, length: self.length)
        while (range.location != NSNotFound) {
            range = (self.string as NSString).range(of: textToFind, options: [], range: range)
            if (range.location != NSNotFound) {
                self.addAttributes(attributes, range: NSRange(location: range.location, length: textToFind.count))
                range = NSRange(location: range.location + range.length, length: self.string.count - (range.location + range.length))
            }
        }
    }
    
    func setBackgroundColor(for textToFind: String? = nil, color: UIColor) {
        set(attributes: [.backgroundColor : color], for: textToFind)
    }
    
    func setTextColor(for textToFind: String? = nil, color: UIColor) {
        set(attributes: [NSAttributedString.Key.foregroundColor : color], for: textToFind)
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
