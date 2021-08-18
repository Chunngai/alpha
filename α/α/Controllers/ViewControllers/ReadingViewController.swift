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
        
        mainView.addGestureRecognizer({
            let gestureRecognizer = UITapGestureRecognizer()
            gestureRecognizer.addTarget(self, action: #selector(removeExplanationLabel))
            return gestureRecognizer
        }())
        
        mainView.backgroundColor = .lightBlue
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        
        return mainView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        self.mainView.addSubview(label)
        
        label.backgroundColor = self.mainView.backgroundColor
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        
        return label
    }()
    
    lazy var separationLine: SeparationLine = {
        let line = SeparationLine()
        self.mainView.addSubview(line)
        return line
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        self.mainView.addSubview(textView)
        
        textView.addGestureRecognizer({
            let tapGestureRecognizer = UITapGestureRecognizer()
            tapGestureRecognizer.addTarget(self, action: #selector(somewhereInTextViewTapped(_:)))
            return tapGestureRecognizer
        }())
        
        textView.backgroundColor = self.mainView.backgroundColor
        textView.isEditable = false
        textView.isSelectable = false
        textView.attributedText = NSAttributedString(
            string: " ",
            attributes: [
                NSAttributedString.Key.paragraphStyle: {
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.lineSpacing = 5
                    paragraph.alignment = .justified
                    paragraph.lineBreakMode = .byWordWrapping
                    return paragraph
                }(),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )
        
        return textView
    }()
    
    lazy var explanationLabelShadowView: UIView = {
        let labelView = UIView()
        labelView.layer.shadowColor = UIColor.lightGray.cgColor
        labelView.layer.shadowOpacity = 0.8
        labelView.layer.shadowRadius = 10
        labelView.layer.shadowOffset = ReadingViewController.shadowOffset
        labelView.tag = 1
        return labelView
    }()
    
    lazy var explanationLabel: PaddingLabel = {
        let label = PaddingLabel(padding: ReadingViewController.explnationLabelinset)
        explanationLabelShadowView.addSubview(label)
        
        label.backgroundColor = self.mainView.backgroundColor
        label.textColor = .darkGray
        label.textAlignment = .left
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        view.backgroundColor = .background
        
        mainView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.80)
            make.width.equalToSuperview().multipliedBy(0.90)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(25)
        }
        titleLabel.attributedText = {
            let title = NSMutableAttributedString(string: reading.title)
            
            let splits = reading.title.split(separator: "\n")
            let mainTitle = splits[0]
            let subTitle = splits[1]
            
            title.setBold(
                for: String(mainTitle),
                fontSize: titleLabel.font.pointSize
            )
            title.set(
                attributes: [.font : textView.font!],
                for: String(subTitle)
            )
            return title
        }()
        
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
        textView.text = makeText(text: reading.text)
        colorVocab()
    }
    
    func updateValues(reading: Reading) {
        self.reading = reading
    }

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
                at: sender.location(in: mainView),
                with: wordItem
            )
        }
    }
    
    @objc func removeExplanationLabel() {
        for view in mainView.subviews where view.tag == 1 {
            view.removeFromSuperview()
        }
    }
    
    // MARK: - Utils
    
    func makeText(text: String) -> String {
        let paras = text.split(separator: "\n")
        var text = ""
        for para in paras {
            text += String(para).leftIndent(by: 4 * 2)
            text += "\n"
        }
        return text
    }
    
    func colorVocab() {
        textView.attributedText = {
            let text = NSMutableAttributedString(attributedString: textView.attributedText!)
            for wordItem in reading.vocab {
                text.setTextColor(for: wordItem.word, color: .systemBlue)
            }
            return text
        }()
    }
    
    func getWordItemFromTappedSpan(span: String) -> WordItem? {
        for wordItem in reading.vocab {
            if wordItem.word.compare(span, options: [String.CompareOptions.caseInsensitive, String.CompareOptions.diacriticInsensitive], range: nil, locale: nil) == .orderedSame {
                return wordItem
            }
        }
        return nil
    }
    
    func popExplanationView(at point: CGPoint, with wordItem: WordItem) {
        let width: CGFloat = 200
        let yOffset: CGFloat = 10

        let safeX: CGFloat
        let safeFactor: CGFloat = 1.2
        if point.x + width * safeFactor <= mainView.frame.maxX {
            safeX = point.x
        } else {
            safeX = mainView.frame.maxX - width * safeFactor
        }
                
        mainView.addSubview(explanationLabelShadowView)
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
    static let shadowOffset: CGSize = CGSize(width: UIScreen.main.bounds.width * 0.01, height: UIScreen.main.bounds.height * 0.006)
    static let explnationLabelinset = UIScreen.main.bounds.width * 0.025
}
