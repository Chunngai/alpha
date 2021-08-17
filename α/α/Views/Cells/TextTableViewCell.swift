//
//  TextTableViewCell.swift
//  α
//
//  Created by Sola on 2021/7/1.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
        
    // MARK: - Views
    
    lazy var label: PaddingLabel = {
        let label = PaddingLabel(edgeInsets: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
        contentView.addSubview(label)
        
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 19)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        updateViews()
    }
    
    func updateViews() {
        self.selectionStyle = .none
        self.backgroundColor = .background
        
        label.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    func updateValues(entry: NSMutableAttributedString) {
        label.attributedText = entry
        if label.actualNumberOfLines == 1 {  // Short sentences.
            label.text! += "\n"
        }
    }
}
