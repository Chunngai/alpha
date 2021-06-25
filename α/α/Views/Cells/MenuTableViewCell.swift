//
//  FunctionTableViewCell.swift
//  α
//
//  Created by Sola on 2021/2/3.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    // MARK: - Init

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        updateInitialViews()
    }
    
    func updateInitialViews() {
        contentView.backgroundColor = .white
    }
}
