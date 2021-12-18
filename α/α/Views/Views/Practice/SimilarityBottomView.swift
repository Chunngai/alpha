//
//  SimilarityBottomView.swift
//  α
//
//  Created by Sola on 2021/10/10.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class SimilarityBottomView: BottomView {

    let prompt = "Similarity: \(SimilarityBottomView.similarityPlaceholder). Reference: "
    
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
        
        label.numberOfLines = 0
        
        backgroundColor = UIColor.hexRGB2UIColor("#FFEF90")
        
        label.textColor = UIColor.intRGB2UIColor(red: 205, green: 150, blue: 0)
    }
    
    func updateValues(similarity: Float, answer: String, input: String) {
        let newPrompt = prompt.replacingOccurrences(
            of: SimilarityBottomView.similarityPlaceholder,
            with: String(Int(similarity * 100)) + "%"
        )
        let attrString = NSMutableAttributedString(string:
            newPrompt
                + "\n"
                + answer
        )
        attrString.set(
            attributes: SimilarityBottomView.promptAttrs,
            for: prompt
        )
        attrString.set(
            attributes: SimilarityBottomView.answerAttrs,
            for: answer
        )
        attrString.set(attributes: IncorrectBottomView.labelAttrs)
        
        // Underlines matched tokens.
        let tokenizer = Tokenizer()
        let inputTokens = tokenizer.tokenize(string: input, withSeparatorsKept: false, lowercase: false)
        for inputToken in inputTokens {
            attrString.setUnderline(forAll: inputToken, color: label.textColor, style: .single, compareOptions: String.CompareOptions.caseInsensitive)
        }
        
        // Removes possible underlines in the prompt.
        attrString.setUnderline(forAll: newPrompt, color: UIColor.hexRGB2UIColor("#FFEF90"), style: .single)
        
        label.attributedText = attrString
    }
}

extension SimilarityBottomView {
    
    // MARK: - Functions
    
    internal func clear() {
        label.text = prompt
    }
    
}

extension SimilarityBottomView {
    
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

extension SimilarityBottomView {
    static let similarityPlaceholder = "SIM"
}
