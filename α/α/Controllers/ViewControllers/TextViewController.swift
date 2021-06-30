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
    
    var vocab: [Word]?
    var sentences: [Sentence]?
        
    // MARK: - Views
    
    var loopView: LoopView!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {        
        view.backgroundColor = .white
        
        // TODO: - Wrap the code here
        loopView = LoopView(frame: CGRect(
            x: 0,
            y: (navigationController?.navigationBar.frame.maxY)!,
            width: view.frame.width,
            height: view.frame.height - (navigationController?.navigationBar.frame.maxY)! - (navigationController?.navigationBar.frame.height)!)
        )
        view.addSubview(loopView)
        loopView.updateValues(vocab: vocab, sentences: sentences)
    }
    
    func updateValues(vocab: [Word]? = nil, sentences: [Sentence]? = nil) {
        self.vocab = vocab
        self.sentences = sentences
    }
}
