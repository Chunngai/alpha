//
//  TextBookTableViewCell.swift
//  α
//
//  Created by Sola on 2021/8/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class HomeTextBookTableViewCell: HomeTableViewCell {

    // MARK: - Init
    
    func updateValues(delegate: HomeViewController) {
        button.setTitle("Text book", for: .normal)
        
        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    @objc override func buttonTapped() {
        delegate.textBookButtonTapped()
    }

}

protocol HomeTextBookTableViewCellDelegate {
    func textBookButtonTapped()
}
