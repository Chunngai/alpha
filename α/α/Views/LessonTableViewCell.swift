//
//  LessonTableViewCell.swift
//  α
//
//  Created by Sola on 2021/2/2.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class LessonTableViewCell: UITableViewCell {

    // MARK: - Models
    
    var lesson: Lesson! {
        didSet {
            label.text = String(lesson.id)
            button.setTitle(lesson.title, for: .normal)
        }
    }
    
    // MARK: - Controllers
    
    var delegate: LessonViewController!
    
    // MARK: - Views
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(buttonTapped))
        return gesture
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        contentView.addSubview(button)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = .lightBlue
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = LessonTableViewCell.buttonTitleEdgeInsets
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.addGestureRecognizer(tapGestureRecognizer)
        button.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(LessonTableViewCell.labelWidth)
        }
        return button
    }()
        
    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        updateInitialViews()
    }
    
    func updateInitialViews() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(LessonTableViewCell.buttonLeftRightInset)
            make.top.equalToSuperview().inset(LessonTableViewCell.buttonTopInset)
            make.bottom.equalToSuperview()
        }
    }
    
    func updateValues(lesson: Lesson, delegate: LessonViewController) {
        self.lesson = lesson
        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    @objc func buttonTapped() {
        delegate.displayFunctionViewController(lesson: lesson)
    }
}

extension LessonTableViewCell {
    static let buttonLeftRightInset: CGFloat = UIScreen.main.bounds.width * 0.02
    static let buttonTopInset: CGFloat = UIScreen.main.bounds.height * 0.005
    static let labelWidth: CGFloat = UIScreen.main.bounds.width * 0.085
    static let buttonTitleEdgeInsets = UIEdgeInsets(
        top: 0,
        left: labelWidth + UIScreen.main.bounds.width * 0.014,
        bottom: 0,
        right: UIScreen.main.bounds.width * 0.024
    )
}

protocol LessonTableViewCellDelegate {
    func displayFunctionViewController(lesson: Lesson)
}
