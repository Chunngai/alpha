//
//  Theme.swift
//  α
//
//  Created by Sola on 2021/8/19.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    static let title1Font = UIFont.preferredFont(forTextStyle: .title1)
    static let title2Font = UIFont.preferredFont(forTextStyle: .title2)
    static let title3Font = UIFont.preferredFont(forTextStyle: .title3)
    static let headlineFont = UIFont.preferredFont(forTextStyle: .headline)
    static let bodyFont = UIFont.preferredFont(forTextStyle: .body)
    static let footNoteFont = UIFont.preferredFont(forTextStyle: .footnote)
    
    static let naviBarLargeTitleTextAttrs = [NSAttributedString.Key.foregroundColor: UIColor.black]
    
    static let backgroundColor = UIColor.systemGray6
    static let lightBlue = UIColor.intRGB2UIColor(red: 210, green: 239, blue: 255)
    static let lightBlueForIcon = UIColor.intRGB2UIColor(red: 190, green: 219, blue: 235)
    static let textColor = UIColor.black
    static let weakTextColor = UIColor.darkGray
    static let highlightedTextColor = UIColor.systemBlue
}
