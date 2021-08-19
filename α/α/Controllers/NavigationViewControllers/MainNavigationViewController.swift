//
//  ViewController.swift
//  α
//
//  Created by Sola on 2021/1/15.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = Theme.naviBarLargeTitleTextAttrs
    }
}
