//
//  VocabViewController.swift
//  α
//
//  Created by Sola on 2021/1/16.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TMP: UIViewController {

    var currentIndex: Int! {
        didSet {
            guard currentIndex >= 0 && currentIndex < texts.count else {
                return
            }
            
            view.backgroundColor = .white
            label.backgroundColor = view.backgroundColor
            label.textColor = .black
            
            label.text = texts[currentIndex].greek
            navigationItem.title = texts[currentIndex].greek
        }
    }
        
    // MARK: - Models
    
    var texts: [Text]!
    var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: TMP.fontSize)
                
        return label
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        view.backgroundColor = .white
        
        let upSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(viewUpSwiped))
        upSwipeGestureRecognizer.direction = .up
        view.addGestureRecognizer(upSwipeGestureRecognizer)
        
        let downSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(viewDownSwiped))
        downSwipeGestureRecognizer.direction = .down
        view.addGestureRecognizer(downSwipeGestureRecognizer)
        
        let leftSiwpeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(viewLeftSwiped))
        leftSiwpeGestureRecognizer.direction = .left
        view.addGestureRecognizer(leftSiwpeGestureRecognizer)
        
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(viewRightSwiped))
        rightSwipeGestureRecognizer.direction = .right
        view.addGestureRecognizer(rightSwipeGestureRecognizer)
        
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }
    }
    
    func updateValues(texts: [Text], centerAlignment: Bool = true) {
        self.texts = texts
        
        if centerAlignment {
            label.textAlignment = .center
        } else {
            label.textAlignment = .left
        }
        
        currentIndex = 0
    }
    
    // MARK: - Gestures

//    func swipeAnimate(direction: UISwipeGestureRecognizer.Direction) {
//        let transition = CATransition();
//        transition.type = CATransitionType.reveal;
//
//        switch direction {
//        case .up:
//            transition.subtype = CATransitionSubtype.fromBottom
//        case .down:
//            transition.subtype = CATransitionSubtype.fromTop
//        case .left:
//            transition.subtype = CATransitionSubtype.fromRight
//        case .right:
//            transition.subtype = CATransitionSubtype.fromLeft
//        default:
//            break
//        }
//
//        //将动画添加middleIamge.layer上
//        label.layer.add(transition, forKey: nil)
//    }
    
    @objc func viewUpSwiped() {
        label.text = texts[currentIndex].english
        view.backgroundColor = .black
        label.backgroundColor = view.backgroundColor
        label.textColor = .white
    }
    
    @objc func viewDownSwiped() {
        label.text = texts[currentIndex].greek
        view.backgroundColor = .white
        label.backgroundColor = view.backgroundColor
        label.textColor = .black
    }
    
    @objc func viewLeftSwiped() {
        currentIndex = currentIndex - 1
        if currentIndex < 0 {
            currentIndex = texts.count - 1
        }
    }
    
    @objc func viewRightSwiped() {
        currentIndex = currentIndex + 1
        if currentIndex == texts.count {
            currentIndex = 0
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TMP {
    static let fontSize: CGFloat = UIScreen.main.bounds.width * 0.06
}
