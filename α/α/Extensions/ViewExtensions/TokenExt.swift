//
//  PosTokenExt.swift
//  α
//
//  Created by Sola on 2021/8/21.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

extension PosToken {
    static func highlightTokensInTextView(textView: RoundCornersBgTextView, font: UIFont = Theme.bodyFont) {
        for token in PosToken.posTokens + LabelToken.labelTokens + UsageToken.usageTokens {
            textView.setRoundCornersBackground(
                forAll: token.token,
                withColor: token.color,
                withFont: font
            )
        }
    }
}
