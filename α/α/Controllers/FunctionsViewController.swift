//
//  FunctionSelectionViewController.swift
//  α
//
//  Created by Sola on 2021/1/16.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class FunctionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellLabelDict: [Int: String] = [
        0: "Learn",
        1: "Vocab",
        2: "Sentences",
        3: "Test"
    ]
    
    // MARK: - Models
    
    var lesson: Lesson!
    
    // MARK: - Controllers
    
    // TODO: protocol
    var delegate: LessonViewController!
    
    // MARK: - Views
    
//    lazy var functionStackView: UIStackView = {
//        let learningButtonView = FunctionButtonView()
//        learningButtonView.updateValues(title: "Learning")
//        learningButtonView.button.addTarget(self, action: #selector(learningButtonTapped), for: .touchUpInside)
//
//        let vocabButtonView = FunctionButtonView()
//        vocabButtonView.updateValues(title: "Vocab")
//        vocabButtonView.button.addTarget(self, action: #selector(vocabButtonTapped), for: .touchUpInside)
//
//        let sentencesButtonView = FunctionButtonView()
//        sentencesButtonView.updateValues(title: "Sentences")
//        sentencesButtonView.button.addTarget(self, action: #selector(sentencesButtonTapped), for: .touchUpInside)
//
//        let stackView = UIStackView(arrangedSubviews: [learningButtonView, vocabButtonView, sentencesButtonView])
//        view.addSubview(stackView)
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .fillEqually
//
//        learningButtonView.snp.makeConstraints { (make) in
//            make.width.equalToSuperview()
//        }
//        vocabButtonView.snp.makeConstraints { (make) in
//            make.width.equalToSuperview()
//        }
//        sentencesButtonView.snp.makeConstraints { (make) in
//            make.width.equalToSuperview()
//        }
//
//        return stackView
//    }()
    
    lazy var lessonLabel: UILabel = {
        let label = UILabel()
        titleLabel.addSubview(label)
        label.backgroundColor = UIColor.lightBlue
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.maskedCorners = CACornerMask(rawValue:CACornerMask.layerMaxXMaxYCorner.rawValue)
        label.layer.masksToBounds = true
        label.text = "Lesson \(lesson.id!)"
        
        return label
    }()
    
    lazy var titieLabelShadowView: UIView = {
        let labelView = UIView()
        view.addSubview(labelView)
        
//        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25), cornerRadius: 10)
//        labelView.layer.shadowPath = path.cgPath
        labelView.layer.shadowColor = UIColor.lightGray.cgColor
        labelView.layer.shadowOpacity = 0.8
        labelView.layer.shadowRadius = 10
        labelView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        return labelView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        titieLabelShadowView.addSubview(label)
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.text = lesson.title
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        return label
    }()
    
    lazy var tableShadowView: UIView = {
        let labelView = UIView()
        view.addSubview(labelView)
        
//        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25), cornerRadius: 10)
//        labelView.layer.shadowPath = path.cgPath
        labelView.layer.shadowColor = UIColor.lightGray.cgColor
        labelView.layer.shadowOpacity = 0.8
        labelView.layer.shadowRadius = 10
        labelView.layer.shadowOffset = CGSize(width: 5, height: 5)
            
            return labelView
        }()
    
    lazy var functionTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableShadowView.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(FunctionTableViewCell.classForCoder(), forCellReuseIdentifier: FunctionsViewController.functionCellReuseIdentifier)
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 15
        tableView.estimatedRowHeight = FunctionsViewController.tableViewEstimatedRowHeight
        tableView.rowHeight = FunctionsViewController.tableViewrowHeight
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        navigationItem.largeTitleDisplayMode = .never
//        navigationItem.title = "Lesson \(lesson.id!)"
        
        view.backgroundColor = .white
        
        lessonLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.23)
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        titieLabelShadowView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.12)
            make.height.equalTo(UIScreen.main.bounds.height * 0.25)
            make.width.equalTo(UIScreen.main.bounds.width * 0.9)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.98)
            make.height.equalToSuperview().multipliedBy(0.95)
        }
        
        tableShadowView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titieLabelShadowView.snp.bottom).offset(UIScreen.main.bounds.height * 0.025)
            make.height.equalTo(FunctionsViewController.tableViewrowHeight * 4)
            make.width.equalTo(titieLabelShadowView.snp.width)
        }
        functionTableView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.98)
            make.height.equalToSuperview().multipliedBy(0.95)
        }
        
//        functionStackView.snp.makeConstraints { (make) in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
//            make.width.equalToSuperview()
//        }
//
//        if lesson.vocab.count == 0 {
//            let vocabButtonView = functionStackView.arrangedSubviews[1] as! FunctionButtonView
//            vocabButtonView.button.backgroundColor = .lightGray
//        }
//        if lesson.sentences.count == 0 {
//            let sentencesButtonView = functionStackView.arrangedSubviews[2] as! FunctionButtonView
//            sentencesButtonView.button.backgroundColor = .lightGray
//        }
    }
    
    func updateValues(lesson: Lesson, delegate: LessonViewController) {
        self.lesson = lesson
        
        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    @objc func learningButtonTapped() {
        let learningViewController = LearningViewController()
        delegate.navigationController?.pushViewController(learningViewController, animated: true)
    }
    
    @objc func vocabButtonTapped() {
        guard lesson.vocab.count > 0 else { return }
        
        let vocabViewController = TextViewController()
        vocabViewController.updateValues(texts: lesson.vocab)
        delegate.navigationController?.pushViewController(vocabViewController, animated: true)
    }
    
    @objc func sentencesButtonTapped() {
        guard lesson.sentences.count > 0 else { return }
        
        let sentencesViewController = TextViewController()
        sentencesViewController.updateValues(texts: lesson.sentences)
        delegate.navigationController?.pushViewController(sentencesViewController, animated: true)
    }
    
    // MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: FunctionsViewController.functionCellReuseIdentifier) as! FunctionTableViewCell
        let cell = UITableViewCell(style: .default, reuseIdentifier: FunctionsViewController.functionCellReuseIdentifier)
        cell.textLabel?.text = cellLabelDict[indexPath.row]
        cell.imageView?.image = UIImage(imageLiteralResourceName: "lesson_icon")
        
        return cell
    }
}

extension FunctionsViewController {
    static let functionCellReuseIdentifier = "FunctionTableViewCell"
    static let tableViewEstimatedRowHeight: CGFloat = UIScreen.main.bounds.height * 0.145
    static let tableViewrowHeight: CGFloat = UIScreen.main.bounds.height * 0.090
}
