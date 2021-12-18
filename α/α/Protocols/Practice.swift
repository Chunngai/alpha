//
//  Practice.swift
//  α
//
//  Created by Sola on 2021/10/8.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

protocol Practice: UIView {
    
    // TODO: - arrange the vars here.
    var question: String { get }
    var answer: String { get }
    
    func check() -> Float
}
