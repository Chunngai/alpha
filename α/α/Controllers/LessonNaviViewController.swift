//
//  ViewController.swift
//  α
//
//  Created by Sola on 2021/1/15.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class LessonNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
