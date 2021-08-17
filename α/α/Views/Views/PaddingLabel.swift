//
//  LabelWithPadding.swift
//  α
//
//  Created by Sola on 2021/8/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

@dynamicMemberLookup
class PaddingLabel: UIView {

    var edgeInsets: UIEdgeInsets!
    
    lazy var label: UILabel = {
        let label = UILabel()
        addSubview(label)
        return label
    }()
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
        self.init(frame: CGRect.zero)
        
        self.edgeInsets = edgeInsets
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(edgeInsets.top)
            make.bottom.equalToSuperview().inset(edgeInsets.bottom)
            make.left.equalToSuperview().inset(edgeInsets.left)
            make.right.equalToSuperview().inset(edgeInsets.right)
        }
    }
    
    convenience init(padding: CGFloat) {
        self.init(edgeInsets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    convenience init(padding: Int) {
        self.init(padding: CGFloat(padding))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PaddingLabel {
    subscript<T>(dynamicMember keyPath: WritableKeyPath<UILabel, T>) -> T {
        get {
            label[keyPath: keyPath]
        }
        set {
            label[keyPath: keyPath] = newValue
        }
    }
}

extension PaddingLabel {
    var actualNumberOfLines: Int {
        let maxSize = CGSize(width: label.frame.size.width, height: CGFloat(Float.infinity))
        let charSize = label.font.lineHeight
        let text = (label.text ?? "") as NSString
        
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : label.font!], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height / charSize))
        return linesRoundedUp
    }
}
