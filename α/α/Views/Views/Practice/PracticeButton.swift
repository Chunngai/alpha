//
//  PracticeButton.swift
//  α
//
//  Created by Sola on 2021/10/8.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class PracticeButton: UIButton {

    var isActivated: Bool = false
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension PracticeButton {
    
    func activate() {
        isActivated = true
        setToCorrectState()
    }
    
    func inactivate() {
        isActivated = false
        setTitleColor(UIColor.hexRGB2UIColor("AFAFAF"), for: .normal)
        backgroundColor = UIColor.hexRGB2UIColor("#E5E5E5")
    }
    
    func setToCorrectState() {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.hexRGB2UIColor("#58CC02")
    }
    
    func setToIncorrectState() {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.hexRGB2UIColor("#FF4B4B")
    }
    
    func setToSimilarityState() {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.hexRGB2UIColor("#FFC800")
    }
}
