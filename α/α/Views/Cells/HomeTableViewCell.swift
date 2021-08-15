//
//  LessonTableViewCell.swift
//  α
//
//  Created by Sola on 2021/2/2.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Controllers
    
    var delegate: HomeViewController!
    
    // MARK: - Views
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        contentView.addSubview(button)
        
        button.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(HomeTableViewCell.labelWidth)
        }
        
        var tapGestureRecognizer: UITapGestureRecognizer = {
            let recognizer = UITapGestureRecognizer()
            recognizer.addTarget(self, action: #selector(buttonTapped))
            return recognizer
        }()
        button.addGestureRecognizer(tapGestureRecognizer)
        
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = .lightBlue
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = HomeTableViewCell.buttonTitleEdgeInsets
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        
        return button
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
        self.backgroundColor = .background
        
        button.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalToSuperview().inset(HomeTableViewCell.buttonTopInset)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc func buttonTapped() {
    }
}

extension HomeTableViewCell {
    static let labelWidth: CGFloat = UIScreen.main.bounds.width * 0.085
    
    static let buttonTopInset: CGFloat = UIScreen.main.bounds.height * 0.005
    static let buttonTitleEdgeInsets = UIEdgeInsets(
        top: 0,
        left: labelWidth + UIScreen.main.bounds.width * 0.030,
        bottom: 0,
        right: UIScreen.main.bounds.width * 0.030
    )
}
