//
//  VocabularyTableViewCell.swift
//  α
//
//  Created by Sola on 2021/8/18.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class VocabularyTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy var textView: TextViewWithRoundCornersBackground = {
        let textStorage = NSTextStorage()

        let textLayoutManager = LayoutManagerForRoundedCornersBackground()
        textLayoutManager.cornerRadius = 5
        textStorage.addLayoutManager(textLayoutManager)
        
        let textContainer = NSTextContainer(size: self.contentView.bounds.size)
        textLayoutManager.addTextContainer(textContainer)
        
        // TODO: - Wrap the code above.
        
        let textView = TextViewWithRoundCornersBackground(frame: CGRect.zero, textContainer: textContainer)
        contentView.addSubview(textView)
        
        textView.backgroundColor = contentView.backgroundColor
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: VocabularyTableViewCell.fontSize)
        textView.contentInset = VocabularyTableViewCell.contentInset
        
        return textView
    }()
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        updateInitialViews()
    }
    
    func updateInitialViews() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        textView.snp.makeConstraints { (make) in
            make.height.width.equalToSuperview()
        }
    }
    
    func updateValues(wordEntry: String, wordMeanings: [Word.Meanings]) {
        let posList: [String] = getPosList(wordMeanings: wordMeanings)
        
        textView.text = posList.joined(separator: " ") + " " + wordEntry
        
        highlightPos(in: posList)
    }
    
    // MARK: - Utils
    
    func getPosList(wordMeanings: [Word.Meanings]) -> [String] {
        var list: [String] = []
        for item in wordMeanings {
            let pos = Word.posAbbr[item.pos]
            if let pos = pos, !list.contains(pos) {
                list.append(pos)
            }
        }
        return list
    }
    
    func highlightPos(in posList: [String]) {
        for pos in posList {
            textView.textStorage.setAttributes(
                VocabularyTableViewCell.posAttributes,
                range: textView.text!.nsrange(of: pos, options: String.caseAndDiacriticInsensitiveCompareOptions)!
            )
        }
    }
}

extension VocabularyTableViewCell {
    static let fontSize: CGFloat = 16
    static let contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    static let posAttributes: [NSAttributedString.Key: Any] = [
        .backgroundColor : UIColor.lightBlue,
        .font: UIFont.systemFont(ofSize: VocabularyTableViewCell.fontSize)
    ]
}
