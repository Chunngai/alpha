//
//  TextLoopView.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class CardLoopView: UIView, UIScrollViewDelegate {

    var currentPage: Int = 0 {
        didSet {
            updateTexts()
        }
    }
    private var totalPage: Int!
    
    private var isBrief: Bool = true
    
    // MARK: - Models
    
    private var vocab: [Word]? {
        willSet{
            currentPage = 0
        }
        didSet {
            updateTexts()
        }
    }
    private var sentences: [Sentence]? {
        willSet{
            currentPage = 0
        }
        didSet {
            updateTexts()
        }
    }
        
    // MARK: - Views
    
    lazy var width: CGFloat = {
        return self.frame.size.width
    }()
    lazy var height: CGFloat = {
        return self.frame.size.height
    }()
    
    lazy private var cardView0: CardViewSelector = {
        let cardView = CardViewSelector()
        loopScrollView.addSubview(cardView)
        return cardView
    }()
    lazy private var cardView1: CardViewSelector = {
        let cardView = CardViewSelector()
        loopScrollView.addSubview(cardView)
        
        cardView.addGestureRecognizer({
            let tapGestureRecognizer = UITapGestureRecognizer()
            tapGestureRecognizer.numberOfTapsRequired = 2
            tapGestureRecognizer.addTarget(self, action: #selector(viewDoubleTapped))
            return tapGestureRecognizer
        }())
        
        return cardView
    }()
    lazy private var cardView2: CardViewSelector = {
        let cardView = CardViewSelector()
        loopScrollView.addSubview(cardView)
        return cardView
    }()
    
    lazy var loopScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: width * 3.0, height: height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        
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
        cardView0.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        cardView1.snp.makeConstraints { (make) in
            make.left.equalTo(width)
            make.top.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        cardView2.snp.makeConstraints { (make) in
            make.left.equalTo(width * 2)
            make.top.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        loopScrollView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func updateValues(vocab: [Word]?, sentences: [Sentence]?) {
        self.vocab = vocab
        self.sentences = sentences
        
        totalPage = vocab != nil ? vocab!.count : sentences!.count
    }
}
    
extension CardLoopView {
    // MARK: - Actions
    
    @objc func viewDoubleTapped() {
        isBrief.toggle()
        updateTexts()
    }
}

extension CardLoopView {
    // MARK: - Utils
    
    func updateTexts() {
        if let vocab = vocab {
            let textView1Word = vocab[currentPage]
            let textView0Word = currentPage == 0 ? vocab.last! : vocab[currentPage - 1]
            let textView2Word = currentPage == vocab.count - 1 ? vocab.first! : vocab[currentPage + 1]
            
            cardView0.displayWord(word: textView0Word, isBrief: isBrief)
            cardView1.displayWord(word: textView1Word, isBrief: isBrief)
            cardView2.displayWord(word: textView2Word, isBrief: isBrief)
        } else if let sentences = sentences {
            let textView1Sentence = sentences[currentPage]
            let textView0Sentence = currentPage == 0 ? sentences.last! : sentences[currentPage - 1]
            let textView2Sentence = currentPage == sentences.count - 1 ? sentences.first! : sentences[currentPage + 1]
            
            cardView0.displaySentence(sentence: textView0Sentence, isBrief: isBrief)
            cardView1.displaySentence(sentence: textView1Sentence, isBrief: isBrief)
            cardView2.displaySentence(sentence: textView2Sentence, isBrief: isBrief)
        }

        loopScrollView.contentOffset = CGPoint(x: width, y: 0)
    }
}

extension CardLoopView {
    
    private func endScrollMethod(ratio: CGFloat) {
        if ratio <= CardLoopView.leftRatioThreshold {
            if currentPage - 1 < 0 {
                currentPage = totalPage - 1
            } else {
                currentPage -= 1
            }
        }
        if ratio >= CardLoopView.rightRatioThreshold {
            if currentPage == totalPage - 1 {
                currentPage = 0
            } else {
                currentPage += 1
            }
        }
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

extension CardLoopView {
    static let leftRatioThreshold: CGFloat = 0.7
    static let rightRatioThreshold: CGFloat = 1.3
}
