//
//  TextsView.swift
//  α
//
//  Created by Sola on 2021/1/22.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class TextView: UIView {

    var mode: TextView.Mode = .brief {
        didSet {
            if self.mode == .brief {
                briefWordLabel.isHidden = false
                
                detailedWordLabel.isHidden = true
                mearningLabel.isHidden = true
                explanationLabel.isHidden = true
            } else {
                briefWordLabel.isHidden = true
                
                detailedWordLabel.isHidden = false
                mearningLabel.isHidden = false
                explanationLabel.isHidden = false
            }
        }
    }
    
    var lang: TextView.Lang = .greek {
        didSet {
            if lang == .english {
                briefWordLabel.text = text.english
            } else {
                briefWordLabel.text = text.greek
            }
        }
    }
    
    // MARK: - Models
    
    var text: Text! {
        didSet {
            briefWordLabel.text = lang == .greek ? text.greek : text.english
            
            detailedWordLabel.text = text.greek
            mearningLabel.text = text.english
            if let explanation = text.explanation {
                explanationLabel.text = explanation
                explanationLabel.alpha = 1
            } else {
                explanationLabel.text = ""
                explanationLabel.alpha = 0
            }
        }
    }
    
    // MARK: - Views
    
    lazy var briefWordLabel: UILabel = {
        let label = UILabel()
        mainView.addSubview(label)
        label.backgroundColor = mainView.backgroundColor
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: TextView.briefWordFontSize)
        return label
    }()
    
    lazy var detailedWordLabel: UILabel = {
        let label = UILabel()
        mainView.addSubview(label)
        label.backgroundColor = mainView.backgroundColor
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: TextView.detailedWordFontSize)
        return label
    }()
    
    lazy var mearningLabel: EdgeInsetsLabel = {
        let label = EdgeInsetsLabel(top: TextView.inset, left: TextView.inset, bottom: TextView.inset, right: TextView.inset)
        mainView.addSubview(label)
        label.backgroundColor = .lightText
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: TextView.mearningFontSize)
        label.sizeToFit()
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var explanationLabel: EdgeInsetsLabel = {
        let label = EdgeInsetsLabel(top: TextView.inset, left: TextView.inset, bottom: TextView.inset, right: TextView.inset)
        mainView.addSubview(label)
        label.backgroundColor = .lightText
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: TextView.explanationFontSize)
        label.sizeToFit()
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var mainView: UIView = {
        let mainView = UIView()
        addSubview(mainView)
        mainView.backgroundColor = .lightBlue
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        return mainView
    }()

    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.updateViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateViews() {
        mainView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.90)
            make.width.equalToSuperview().multipliedBy(0.90)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        briefWordLabel.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.90)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        detailedWordLabel.isHidden = true
        detailedWordLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(25)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        
        mearningLabel.isHidden = true
        mearningLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailedWordLabel.snp.bottom).offset(20)
            make.leading.equalTo(detailedWordLabel.snp.leading)
            make.width.equalTo(detailedWordLabel.snp.width)
        }
        
        explanationLabel.isHidden = true
        explanationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mearningLabel.snp.bottom).offset(20)
            make.leading.equalTo(detailedWordLabel.snp.leading)
            make.width.equalTo(detailedWordLabel.snp.width)
        }
    }
    
    // MARK: - Utils
    
    func setText(text: Text) {
        self.text = text
    }
    
    func changeMode() {
        if mode == .brief {
            mode = .detailed
        } else {
            mode = .brief
        }
    }
    
    func changeLang() {
        if lang == .english {
            lang = .greek
        } else {
            lang = .english
        }
    }
}

extension TextView {
    static let briefWordFontSize = UIScreen.main.bounds.width * 0.06
    static let detailedWordFontSize = UIScreen.main.bounds.width * 0.09
    static let mearningFontSize = UIScreen.main.bounds.width * 0.05
    static let explanationFontSize = UIScreen.main.bounds.width * 0.04
    static let inset = UIScreen.main.bounds.width * 0.02
}


extension TextView {
    enum Mode {
        case brief
        case detailed
    }
}

extension TextView {
    enum Type_ {
        case word
        case sent
    }
}

extension TextView {
    enum Lang {
        case english
        case greek
    }
}
