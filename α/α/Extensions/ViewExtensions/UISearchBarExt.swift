//
//  UISearchBar.swift
//  α
//
//  Created by Sola on 2021/8/19.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    var isEmpty: Bool {
        if let keyWords = text {
            return keyWords.trimmingWhitespacesAndNewlines().count == 0
        } else {
            return true
        }
    }
    
    var keyWord: String? {
        self.text?.trimmingWhitespacesAndNewlines()
    }
}
