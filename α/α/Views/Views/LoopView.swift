//
//  TextLoopView.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class LoopView: UIView, UIScrollViewDelegate {

    private var currentPage: Int = 0
    
    private var mode: TextViewController.Mode!
    private var isBrief: Bool = true
    
    // MARK: - Models
    
    private var texts: [Text]! {
        willSet{
            currentPage = 0
        }
        didSet{
            self.updateTexts()
        }
    }
    
    // MARK: - Views
    
    lazy var width: CGFloat = {
        return self.frame.size.width
    }()
    lazy var height: CGFloat = {
        return self.frame.size.height
    }()
    
    private let textView0: TextViewSelector = TextViewSelector()
    private let textView1: TextViewSelector = TextViewSelector()
    private let textView2: TextViewSelector = TextViewSelector()
    lazy private var loopScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        addSubview(scrollView)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scrollView.contentSize = CGSize(width: width * 3.0, height: height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        
        textView0.frame = CGRect(x: width * 0.0, y: 0, width: width, height: height)
        textView1.frame = CGRect(x: width * 1.0, y: 0, width: width, height: height)
        textView2.frame = CGRect(x: width * 2.0, y: 0, width: width, height: height)
        scrollView.addSubview(textView0)
        scrollView.addSubview(textView1)
        scrollView.addSubview(textView2)
        
        textView1.addGestureRecognizer({
            let tapGestureRecognizer = UITapGestureRecognizer()
            tapGestureRecognizer.numberOfTapsRequired = 2
            tapGestureRecognizer.addTarget(self, action: #selector(viewDoubleTapped))
            return tapGestureRecognizer
        }())
        
        return scrollView
    }()
    
    // MARK: - Init
        
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.updateViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateViews(){
        
    }
    
    func updateValues(texts: [Text], mode: TextViewController.Mode) {
        self.mode = mode
        self.texts = texts
    }
    
    // MARK: - Actions
    
    @objc func viewDoubleTapped() {
        isBrief.toggle()
        updateTexts()
    }

    // MARK: - Utils
    
    private func updateTexts() {
        let textView1Text = texts[currentPage]
        let textView0Text = currentPage == 0 ? texts.last! : texts[currentPage - 1]
        let textView2Text = currentPage == texts.count - 1 ? texts.first! : texts[currentPage + 1]
                
        textView0.selectView(text: textView0Text, isBrief: isBrief, mode: mode)
        textView1.selectView(text: textView1Text, isBrief: isBrief, mode: mode)
        textView2.selectView(text: textView2Text, isBrief: isBrief, mode: mode)

        loopScrollView.contentOffset = CGPoint(x: width, y: 0)
    }
}

extension LoopView {
    
    private func endScrollMethod(ratio:CGFloat) {
        if ratio <= 0.7 {
            if currentPage - 1 < 0 {
                currentPage = texts.count - 1
            } else {
                currentPage -= 1
            }
        }
        if ratio >= 1.3 {
            if currentPage == texts.count - 1 {
                currentPage = 0
            } else {
                currentPage += 1
            }
        }
        
        self.updateTexts()
    }
    
    // MARK: - UIScrollView delegate
    
    internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let ratio = scrollView.contentOffset.x / width
        self.endScrollMethod(ratio: ratio)
    }
    
    internal func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let ratio = scrollView.contentOffset.x / width
            self.endScrollMethod(ratio: ratio)
        }
    }
}
