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
    private var totalPage: Int!
    private var isBrief: Bool = true
    
    // MARK: - Models
    
    private var vocab: [Word]? {
        willSet{
            currentPage = 0
        }
        didSet{
            self.updateTexts()
        }
    }
    private var sentences: [Sentence]? {
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
    
    func updateValues(vocab: [Word]?, sentences: [Sentence]?) {
        self.vocab = vocab
        self.sentences = sentences
        
        totalPage = vocab != nil ? vocab!.count : sentences!.count
    }
    
    // MARK: - Actions
    
    @objc func viewDoubleTapped() {
        isBrief.toggle()
        updateTexts()
    }

    // MARK: - Utils
    
    private func updateTexts() {
        if let vocab = vocab {
            let textView1Word = vocab[currentPage]
            let textView0Word = currentPage == 0 ? vocab.last! : vocab[currentPage - 1]
            let textView2Word = currentPage == vocab.count - 1 ? vocab.first! : vocab[currentPage + 1]
            
            textView0.displayWord(word: textView0Word, isBrief: isBrief)
            textView1.displayWord(word: textView1Word, isBrief: isBrief)
            textView2.displayWord(word: textView2Word, isBrief: isBrief)
        } else if let sentences = sentences {
            let textView1Sentence = sentences[currentPage]
            let textView0Sentence = currentPage == 0 ? sentences.last! : sentences[currentPage - 1]
            let textView2Sentence = currentPage == sentences.count - 1 ? sentences.first! : sentences[currentPage + 1]
            
            textView0.displaySentence(sentence: textView0Sentence, isBrief: isBrief)
            textView1.displaySentence(sentence: textView1Sentence, isBrief: isBrief)
            textView2.displaySentence(sentence: textView2Sentence, isBrief: isBrief)
        }

        loopScrollView.contentOffset = CGPoint(x: width, y: 0)
    }
}

extension LoopView {
    
    private func endScrollMethod(ratio:CGFloat) {
        if ratio <= 0.7 {
            if currentPage - 1 < 0 {
                currentPage = totalPage - 1
            } else {
                currentPage -= 1
            }
        }
        if ratio >= 1.3 {
            if currentPage == totalPage - 1 {
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
