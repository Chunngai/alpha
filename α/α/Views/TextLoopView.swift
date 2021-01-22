//
//  TextLoopView.swift
//  α
//
//  Created by Sola on 2021/1/17.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextLoopView: UIView, UIScrollViewDelegate {

    //MARK: - setter & getter
    private let loopScrollView: UIScrollView = UIScrollView()
    private let textView0: TextView = TextView()
    private let textView1: TextView = TextView()
    private let textView2: TextView = TextView()
    
    /// 当前页
    public var currentPage: Int = 0

    /// 图片数组
    public var texts: [String] = []{
        willSet{
            currentPage = 0
        }
        didSet{
            self.updateImageData()
        }
    }
    
    /**
     初始化
     
     - returns:
     */
    private func initializeUI(){
        
        let width = self.frame.size.width;
        let height = self.frame.size.height;
        
        loopScrollView.frame = CGRect(x: 0,y: 0,width: width,height: height)
        loopScrollView.contentSize = CGSize(width: width * 3.0,height: height)
        loopScrollView.showsVerticalScrollIndicator = false
        loopScrollView.showsHorizontalScrollIndicator = false
        loopScrollView.delegate = self
        loopScrollView.bounces = false
        loopScrollView.isPagingEnabled = true
        self.addSubview(loopScrollView)
        
        textView0.frame = CGRect(x: 0, y: 0, width: width, height: height)
        textView1.frame = CGRect(x: width, y: 0, width: width, height: height)
        textView2.frame = CGRect(x: width * 2.0, y: 0, width: width, height: height)
        loopScrollView.addSubview(textView0)
        loopScrollView.addSubview(textView1)
        loopScrollView.addSubview(textView2)
    }
    
    //MARK: - life cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initializeUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIScrollView delegate
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let ratio = scrollView.contentOffset.x/self.frame.size.width
        self.endScrollMethod(ratio: ratio)
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            let ratio = scrollView.contentOffset.x/self.frame.size.width
            self.endScrollMethod(ratio: ratio)
        }
    }
    
    //MARK: - reload data
    private func updateImageData(){
        
        if currentPage == 0{
            textView0.label.text = texts.last!
            textView1.label.text = texts[currentPage]
            textView2.label.text = texts[currentPage + 1]
        }else if currentPage == texts.count - 1{
            textView0.label.text = texts[currentPage - 1]
            textView1.label.text = texts[currentPage]
            textView2.label.text = texts.first!
        }else{
            textView0.label.text = texts[currentPage - 1]
            textView1.label.text = texts[currentPage]
            textView2.label.text = texts[currentPage + 1]
        }
        loopScrollView.contentOffset = CGPoint(x: self.frame.size.width,y: 0)
    }

    private func endScrollMethod(ratio:CGFloat){
        if ratio <= 0.7{
            if currentPage - 1 < 0{
                currentPage = texts.count - 1
            }else{
                currentPage -= 1
            }
        }
        if ratio >= 1.3{
            if currentPage == texts.count - 1{
                currentPage = 0
            }else{
                currentPage += 1
            }
        }
        
        self.updateImageData()
    }
}
