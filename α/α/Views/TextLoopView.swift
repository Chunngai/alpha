//
//  TextLoopView.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextLoopView: UIView, UIScrollViewDelegate {

    private var currentPage: Int = 0
    private var currentLang: Lang = .greek
    
    // MARK: - Models
    
    private var texts: [Text]! {
        willSet{
            currentPage = 0
        }
        didSet{
            self.updateText()
        }
    }
    
    // MARK: - Views
    
    lazy var width: CGFloat = {
        return self.frame.size.width
    }()
    lazy var height: CGFloat = {
        return self.frame.size.height
    }()
    
    lazy var doubleTapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.numberOfTapsRequired = 2
        tapGestureRecognizer.addTarget(self, action: #selector(viewDoubleTapped))
        return tapGestureRecognizer
    }()
    
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
        textView1.addGestureRecognizer(doubleTapGestureRecognizer)
        textView2.frame = CGRect(x: width * 2.0, y: 0, width: width, height: height)
        scrollView.addSubview(textView0)
        scrollView.addSubview(textView1)
        scrollView.addSubview(textView2)
        
        return scrollView
    }()
    private let textView0: TextView = TextView()
    private let textView1: TextView = TextView()
    private let textView2: TextView = TextView()
    
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
    
    func updateValues(texts: [Text]) {
        self.texts = texts
    }
    
    // MARK: - Actions
    
    @objc func viewDoubleTapped() {
        currentLang = currentLang == .greek ? .english : .greek
        updateText()
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

    // MARK: - Utils
    
    private func getTextContent(text: Text) -> String {
        switch currentLang {
        case .greek: return text.greek
        case .english: return text.english
        }
    }
    
    private func updateText() {
        textView1.label.text = getTextContent(text: texts[currentPage])
        textView0.label.text = getTextContent(text: currentPage == 0 ? texts.last! : texts[currentPage - 1])
        textView2.label.text = getTextContent(text: currentPage == texts.count - 1 ? texts.first! : texts[currentPage + 1])
        
        loopScrollView.contentOffset = CGPoint(x: width, y: 0)
    }
    
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
        
        self.updateText()
    }
}
