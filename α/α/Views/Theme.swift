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
    
    // MARK: - Fonts
    
    static let title1Font = UIFont.preferredFont(forTextStyle: .title1)
    static let title2Font = UIFont.preferredFont(forTextStyle: .title2)
    static let title3Font = UIFont.preferredFont(forTextStyle: .title3)
    static let headlineFont = UIFont.preferredFont(forTextStyle: .headline)
    static let bodyFont = UIFont.preferredFont(forTextStyle: .body)
    static let footNoteFont = UIFont.preferredFont(forTextStyle: .footnote)
    
    // MARK: - Colors
    
    static let backgroundColor = UIColor.systemGray6
    static let lightBlue = UIColor.intRGB2UIColor(red: 210, green: 239, blue: 255)
    static let lightBlueForIcon = UIColor.intRGB2UIColor(red: 190, green: 219, blue: 235)
    static let textColor = UIColor.black
    static let weakTextColor = UIColor.darkGray
    static let highlightedTextColor = UIColor.systemBlue
    
    static let verbColor: UIColor = UIColor.intRGB2UIColor(red: 205, green: 229, blue: 255)
    static let nounColor: UIColor = UIColor.intRGB2UIColor(red: 255, green: 236, blue: 160)
    static let pronounColor: UIColor = UIColor.intRGB2UIColor(red: 255, green: 220, blue: 151)
    static let adjectiveColor: UIColor = UIColor.intRGB2UIColor(red: 255, green: 197, blue: 181)
    static let adverbColor: UIColor = UIColor.intRGB2UIColor(red: 255, green: 219, blue: 232)
    static let prepositionColor: UIColor = UIColor.intRGB2UIColor(red: 223, green: 236, blue: 213)
    static let conjunctionColor: UIColor = UIColor.intRGB2UIColor(red: 226, green: 226, blue: 251)
    static let particleColor: UIColor = UIColor.intRGB2UIColor(red: 220, green: 214, blue: 205)
}
