//
//  ReadingViewController.swift
//  α
//
//  Created by Sola on 2021/6/30.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class ReadingViewController: UIViewController {

    // MARK: - Models
    
    var reading: Reading!
    
    // MARK: - Views
    
    lazy var mainView: UIView = {
        let mainView = UIView()
        view.addSubview(mainView)
        return mainView
    }()
    
    lazy var cardView: UIView = {
        let cardView = UIView()
        mainView.addSubview(cardView)
        
        cardView.addGestureRecognizer({
            let gestureRecognizer = UITapGestureRecognizer()
            gestureRecognizer.addTarget(self, action: #selector(removeExplanationLabel))
            return gestureRecognizer
        }())
        
        cardView.backgroundColor = Theme.lightBlue
        cardView.layer.cornerRadius = ReadingViewController.cornerRadius
        cardView.layer.masksToBounds = true
        
        return cardView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        cardView.addSubview(label)
        
        label.backgroundColor = cardView.backgroundColor
        label.numberOfLines = 0
        label.textColor = Theme.textColor

        return label
    }()
    
    lazy var separationLine: SeparationLine = {
        let line = SeparationLine()
        cardView.addSubview(line)
        return line
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        cardView.addSubview(textView)
        
        textView.addGestureRecognizer({
            let tapGestureRecognizer = UITapGestureRecognizer()
            tapGestureRecognizer.addTarget(self, action: #selector(somewhereInTextViewTapped(_:)))
            return tapGestureRecognizer
        }())
        
        textView.backgroundColor = cardView.backgroundColor
        textView.isEditable = false
        textView.isSelectable = false
        textView.showsVerticalScrollIndicator = false
        textView.attributedText = NSAttributedString(
            string: " ",
            attributes: ReadingViewController.textViewAttrs
        )
        
        return textView
    }()
    
    lazy var explanationLabelShadowView: UIView = {
        let labelView = UIView()
        labelView.layer.shadowColor = UIColor.lightGray.cgColor
        labelView.layer.shadowOpacity = ReadingViewController.shadowOpacity
        labelView.layer.shadowRadius = ReadingViewController.shadowRadius
        labelView.layer.shadowOffset = ReadingViewController.shadowOffset
        labelView.tag = 1
        return labelView
    }()
    
    lazy var explanationLabel: PaddingLabel = {
        let label = PaddingLabel(padding: ReadingViewController.explnationInset)
        explanationLabelShadowView.addSubview(label)
        
        label.backgroundColor = cardView.backgroundColor
        label.textColor = Theme.weakTextColor
        label.textAlignment = .left
        label.layer.cornerRadius = ReadingViewController.cornerRadius
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.font = Theme.footNoteFont
        
        return label
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        updateLayouts()
        
        titleLabel.attributedText = makeTitle()
        textView.text = makeText()
        hightlightVocab()
    }
    
    func updateViews() {
        view.backgroundColor = Theme.backgroundColor
    }
     
    func updateLayouts() {
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        cardView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.90)
            make.width.equalToSuperview().multipliedBy(0.90)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(25)
        }
        
        separationLine.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(0.5)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(separationLine.snp.bottom).offset(30)
            make.bottom.equalToSuperview().inset(50)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }
    }
    
    func updateValues(reading: Reading) {
        self.reading = reading
    }
}

extension ReadingViewController {
    // MARK: - Actions
    
    @objc func somewhereInTextViewTapped(_ sender: UITapGestureRecognizer) {
        func getPointInTextView() -> CGPoint {
            var point = sender.location(in: tappedTextView)
            point.x -= tappedTextView.textContainerInset.left
            point.y -= tappedTextView.textContainerInset.top
            return point
        }
        
        func isValidCharacterIndex(characterIndex: Int) -> Bool {
            return characterIndex < tappedTextView.textStorage.length
        }
        
        func getForegroundColor(characterIndex: Int) -> UIColor {
            let foregroundColor = tappedTextView.attributedText.attribute(
                NSAttributedString.Key.foregroundColor,
                at: characterIndex,
                effectiveRange: nil
            )
            return foregroundColor as! UIColor
        }
        
        removeExplanationLabel()
        
        let tappedTextView = sender.view as! UITextView
                
        let tappedCharacterIndex = tappedTextView.layoutManager.characterIndex(
            for: getPointInTextView(),
            in: tappedTextView.textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )
        if !isValidCharacterIndex(characterIndex: tappedCharacterIndex) {
            return
        }
        if getForegroundColor(characterIndex: tappedCharacterIndex) != .systemBlue {
            return
        }
        
        var characterIndexLowerBound: Int = tappedCharacterIndex
        var characterIndexUpperBound: Int = tappedCharacterIndex
        while true {
            characterIndexLowerBound -= 1
            if !isValidCharacterIndex(characterIndex: characterIndexLowerBound) || getForegroundColor(characterIndex: characterIndexLowerBound) != .systemBlue {
                characterIndexLowerBound += 1
                break
            }
        }
        while true {
            characterIndexUpperBound += 1
            if !isValidCharacterIndex(characterIndex: characterIndexUpperBound) || getForegroundColor(characterIndex: characterIndexUpperBound) != .systemBlue {
                characterIndexUpperBound -= 1
                break
            }
        }

        let tappedRange = NSRange(
            location: characterIndexLowerBound,
            length: characterIndexUpperBound - characterIndexLowerBound + 1
        )
        let tappedSpan = (tappedTextView.attributedText.string as NSString).substring(with: tappedRange)
        
        let wordItem = getWordItemFromTappedSpan(span: tappedSpan)
        if let wordItem = wordItem {
            popExplanationView(
                at: sender.location(in: cardView),
                with: wordItem
            )
        }
    }
    
    @objc func removeExplanationLabel() {
        for view in cardView.subviews where view.tag == 1 {
            view.removeFromSuperview()
        }
    }
}
 
extension ReadingViewController {
    // MARK: - Utils
    
    func makeTitle() -> NSMutableAttributedString {
        let title = NSMutableAttributedString(string: reading.title)
        let splits = reading.title.split(separator: "\n")
        
        let mainTitle = splits[0]
        title.set(
            attributes: [.font: Theme.title1Font],
            for: String(mainTitle)
        )
        
        let subTitle = splits[1]
        title.set(
            attributes: [.font: Theme.title2Font],
            for: String(subTitle)
        )
        
        return title
    }
    
    func makeText() -> String {
        let paras = reading.text.split(separator: "\n")
        var text = ""
        for para in paras {
            text += String(para).leftIndent(by: 4 * 2)
            text += "\n"
        }
        return text
    }
    
    func hightlightVocab() {
        textView.attributedText = {
            let text = NSMutableAttributedString(attributedString: textView.attributedText!)
            for wordItem in reading.vocab {
                text.setTextColor(for: wordItem.word, color: Theme.highlightedTextColor)
            }
            return text
        }()
    }
    
    func getWordItemFromTappedSpan(span: String) -> Reading.WordItem? {
        for wordItem in reading.vocab {
            if wordItem.word.compare(span, options: String.caseAndDiacriticInsensitiveCompareOptions, range: nil, locale: nil) == .orderedSame {
                return wordItem
            }
        }
        return nil
    }
    
    func popExplanationView(at point: CGPoint, with wordItem: Reading.WordItem) {
        let width: CGFloat = ReadingViewController.explanationWidth
        let yOffset: CGFloat = ReadingViewController.explanationYOffset

        let safeX: CGFloat
        let safeFactor: CGFloat = ReadingViewController.explanationSafeFactor
        if point.x + width * safeFactor <= cardView.frame.maxX {
            safeX = point.x
        } else {
            safeX = cardView.frame.maxX - width * safeFactor
        }
                
        cardView.addSubview(explanationLabelShadowView)
        explanationLabelShadowView.snp.makeConstraints { (make) in
            make.leading.equalTo(safeX)
            make.top.equalTo(point.y + yOffset)
            make.width.equalTo(width)
        }
        
        explanationLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        explanationLabel.text = wordItem.explanation
    }
}

extension ReadingViewController {
    static let textViewAttrs: [NSAttributedString.Key: Any] = [
        .paragraphStyle: Theme.paraStyle1,
        .font: Theme.bodyFont,
        .foregroundColor: UIColor.black
    ]
    
    static let shadowOpacity: Float = 0.8
    static let shadowRadius: CGFloat = 10
    static let shadowOffset: CGSize = CGSize(width: 4, height: 5)
    static let cornerRadius: CGFloat = 10
    static let explnationInset = 10
    static let explanationWidth: CGFloat = 200
    static let explanationYOffset: CGFloat = 10
    static let explanationSafeFactor: CGFloat = 1.2
}
