//
//  TextTableViewCell.swift
//  α
//
//  Created by Sola on 2021/7/1.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    var entry: String!
    
    // MARK: - Views
    
    lazy var label: UILabel = {
        let label = EdgeInsetsLabel(
            top: 15,
            left: 10,
            bottom: 15,
            right: 10
        )
        contentView.addSubview(label)
                
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .lightBlue
        label.textColor = .black
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
        self.backgroundColor = .white
        
        label.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func updateValues(entry: String) {
        self.entry = entry
        label.text = entry + String.init(repeating: " ", count: 5)  // MARK: - TODO edde inset label "..."
    }
}
