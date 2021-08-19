//
//  File.swift
//  α
//
//  Created by Sola on 2021/8/19.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

struct PosToken: Equatable {
    var pos: String!
    
    var token: String {
        if let posAbbr = Word.posAbbrs[pos] {
            return posAbbr.indent(leftIndent: 1, rightIndent: 1)
        } else {
            return pos
        }
    }
    var color: UIColor {
        return Word.posColors[pos] ?? UIColor.lightText
    }
}
 
extension PosToken {
    // MARK: - Equatable
    
    static func == (lhs: PosToken, rhs: PosToken) -> Bool {
        return lhs.pos == rhs.pos
    }
}

extension PosToken {
    static var posTokens: [PosToken] {
        var posTokens: [PosToken] = []
        for pos in Word.posList {
            posTokens.append(PosToken(pos: pos))
        }
        return posTokens
    }
    
    static func highlightPosTokensInTextView(textView: UITextView, font: UIFont = Theme.bodyFont) {
        for posToken in PosToken.posTokens {
            textView.textStorage.set(
                attributes: [
                    .font: font,
                    .backgroundColor: posToken.color
                ],
                forAll: posToken.token
            )
        }
    }
}
