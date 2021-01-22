//
//  TextsViewController.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    // MARK: - Models
        
    var texts: [Text]!
        
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        view.backgroundColor = .white
        
        // TODO: - Wrap the code here
        let rect = CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.height - (navigationController?.navigationBar.frame.maxY)! - (navigationController?.navigationBar.frame.height)!)
        let textLoopView = TextLoopView(frame: rect)
        self.view.addSubview(textLoopView)
        textLoopView.updateValues(texts: texts)
    }
    
    func updateValues(texts: [Text]) {
        self.texts = texts
    }
}
