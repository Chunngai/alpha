//
//  StringExtension.swift
//  α
//
//  Created by Sola on 2021/8/19.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

extension String {
    static let caseAndDiacriticInsensitiveCompareOptions: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
    
    func caseAndDiacriticInsensitivelyContains(_ aString: String) -> Bool {
        return self.range(of: aString, options: String.caseAndDiacriticInsensitiveCompareOptions) != nil
    }
}

extension String {
    func nsrange(of aString: String, options: String.CompareOptions) -> NSRange? {
        let range = self.range(of: aString, options: options, range: nil, locale: nil)
        if let range = range {
            return NSRange(range, in: self)
        } else {
            return nil
        }
    }
}
    
extension String {
    func leftIndent(by indent: Int) -> String {
        return String(repeating: " ", count: indent) + self
    }
    
    func indent(leftIndent: Int, rightIndent: Int) -> String {
        return String(repeating: " ", count: leftIndent) + self + String(repeating: " ", count: rightIndent)
    }
}

extension String {
    func split(with separators: String, byKeeping separatorsToKeep: String) -> [String] {
        var stringBuffer = ""
        var splits: [String] = []
        for character in self {
            if separators.contains(character) {
                if !stringBuffer.isEmpty {
                    splits.append(stringBuffer)
                }
                if separatorsToKeep.contains(character) {
                    splits.append(String(character))
                }
                
                stringBuffer = ""
            }
            else {
                stringBuffer += String(character)
            }
        }
        if !stringBuffer.isEmpty {
            splits.append(stringBuffer)
        }
        return splits
    }
}

extension String {
    func trimmingWhitespacesAndNewlines() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
