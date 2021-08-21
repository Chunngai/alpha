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
    static func highlightPosTokensInTextView(textView: RoundCornersBgTextView, font: UIFont = Theme.bodyFont) {
        for posToken in PosToken.posTokens {
            textView.setRoundCornersBackground(
                forAll: posToken.token,
                withColor: posToken.color,
                withFont: font
            )
        }
    }
}
