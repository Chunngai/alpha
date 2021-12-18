//
//  IncorrectButtonView.swift
//  α
//
//  Created by Sola on 2021/10/8.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class IncorrectBottomView: BottomView {

    let prompt = "Correct solution: "
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateViews()
        updateLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateViews() {
        super.updateViews()
        
        backgroundColor = UIColor.hexRGB2UIColor("#FFDFE0")
        
        label.textColor = UIColor.hexRGB2UIColor("#EA2B2B")
        label.text = "Correct solution: "
    }
    
    func updateValues(answer: String) {
        let attrString = NSMutableAttributedString(string: prompt + "\n" + answer)
        attrString.set(
            attributes: IncorrectBottomView.promptAttrs,
            for: prompt
        )
        attrString.set(
            attributes: IncorrectBottomView.answerAttrs,
            for: answer
        )
        attrString.set(attributes: IncorrectBottomView.labelAttrs)
        label.attributedText = attrString
    }
}

extension IncorrectBottomView {
    
    // MARK: - Functions
    
    internal func clear() {
        label.text = prompt
    }
    
}

extension IncorrectBottomView {
    
    static let promptAttrs: [NSAttributedString.Key: Any] = [
        .font : UIFont(
            name: "Arial Rounded MT Bold",
            size: Theme.title2Font.pointSize
        )!
    ]
    static let answerAttrs: [NSAttributedString.Key: Any] = [
        .font : UIFont.systemFont(
            ofSize: Theme.bodyFont.pointSize,
            weight: .regular
        )
    ]
    
    static let labelAttrs: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.paragraphStyle : Theme.paraStyle2,
    ]
}
