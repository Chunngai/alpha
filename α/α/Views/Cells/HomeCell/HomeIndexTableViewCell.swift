//
//  TextBookTableViewCell.swift
//  α
//
//  Created by Sola on 2021/8/14.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class HomeIndexTableViewCell: HomeTableViewCell {

    var funcWhenTapped: (() -> Void)!
    
    // MARK: - Init
    
    func updateValues(buttonTitle: String, funcWhenTapped: @escaping () -> Void) {
        button.setTitle(buttonTitle, for: .normal)
        
        self.funcWhenTapped = funcWhenTapped
    }
    
    // MARK: - Actions
    
    @objc override func buttonTapped() {
        funcWhenTapped()
    }

}

protocol HomeIndexTableViewCellDelegate {
    func textBookButtonTapped()
    func vocabularyButtonTapped()
}
