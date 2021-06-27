//
//  TextsViewController.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var mode: TextViewController.Mode!
    
    // MARK: - Models
    
    var texts: [Text]!
        
    // MARK: - Views
    
    var loopView: LoopView!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = .white
        
        // TODO: - Wrap the code here
        loopView = LoopView(frame: CGRect(
            x: 0,
            y: (navigationController?.navigationBar.frame.maxY)!,
            width: view.frame.width,
            height: view.frame.height - (navigationController?.navigationBar.frame.maxY)! - (navigationController?.navigationBar.frame.height)!)
        )
        view.addSubview(loopView)
        loopView.updateValues(texts: texts, mode: mode)
    }
    
    func updateValues(texts: [Text], mode: TextViewController.Mode) {
        self.texts = texts
        self.mode = mode
    }
}

extension TextViewController {
    enum Mode {
        case vocabulary
        case sentences
    }
}
