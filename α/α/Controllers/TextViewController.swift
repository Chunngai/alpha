//
//  TextsViewController.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var type_: TextView.Type_!
    
    // MARK: - Models
        
    var texts: [Text]!
        
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = .white
        
        // TODO: - Wrap the code here
        let textLoopView = TextLoopView(frame: CGRect(
            x: 0,
            y: (navigationController?.navigationBar.frame.maxY)!,
            width: view.frame.width,
            height: view.frame.height - (navigationController?.navigationBar.frame.maxY)! - (navigationController?.navigationBar.frame.height)!)
        )
        view.addSubview(textLoopView)
        textLoopView.updateValues(texts: texts, type_: type_)
    }
    
    func updateValues(texts: [Text], type_: TextView.Type_) {
        self.texts = texts
        self.type_ = type_
    }
}
