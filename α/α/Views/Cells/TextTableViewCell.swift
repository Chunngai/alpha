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
    
//    lazy var numberLabel: UILabel = {
//        let label = UILabel()
//        contentView.addSubview(label)
//
////        label.layer.cornerRadius = label.frame.width / 2
//        label.layer.masksToBounds = true
//        label.backgroundColor = .lightBlue
//
//        return label
//    }()
    
    lazy var label: EdgeInsetsLabel = {
        let label = EdgeInsetsLabel(
            top: 10,
            left: 15,
            bottom: 10,
            right: 15
        )
        contentView.addSubview(label)
                
//        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .white
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
        self.backgroundColor = .background
        
//        numberLabel.snp.makeConstraints { (make) in
//            make.left.equalToSuperview()
//            make.height.equalTo(30)
//            make.width.equalTo(30)
//            make.centerY.equalToSuperview()
//        }
        
        label.snp.makeConstraints { (make) in
//            make.left.equalTo(numberLabel.snp.right).offset(10)
            make.width.equalToSuperview()
//            make.right.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()

            // Only one line in the label is displayed
            // on the actual device
            // when using the following line.
//            make.centerY.equalToSuperview()
        }
    }
    
    func updateValues(entry: NSMutableAttributedString) {
        label.attributedText = entry
    }
}
