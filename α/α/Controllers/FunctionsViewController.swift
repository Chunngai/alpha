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
        0: "Learning",
        1: "Vocabulary",
        2: "Sentences",
        3: "Reading",
        4: "Test"
    ]
    
    let cellImageViewDict: [Int: UIImage] = [
        0: UIImage(imageLiteralResourceName: "learning"),
        1: UIImage(imageLiteralResourceName: "vocab_sents_reading"),
        2: UIImage(imageLiteralResourceName: "vocab_sents_reading"),
        3: UIImage(imageLiteralResourceName: "vocab_sents_reading"),
        4: UIImage(imageLiteralResourceName: "test")
    ]
    
    // MARK: - Models
    
    var lesson: Lesson!
    
    // MARK: - Controllers
        
    var delegate: LessonViewController!
    
    // MARK: - Views
    
    lazy var lessonLabel: UILabel = {
        let label = UILabel()
        titleLabel.addSubview(label)
        label.backgroundColor = UIColor.lightBlue
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = titleLabel.layer.cornerRadius
        label.layer.maskedCorners = CACornerMask(rawValue:CACornerMask.layerMaxXMaxYCorner.rawValue)
        label.layer.masksToBounds = true
        label.text = "Lesson \(lesson.id!)"
        
        return label
    }()
    
    lazy var titieLabelShadowView: UIView = {
        let labelView = UIView()
        view.addSubview(labelView)
        labelView.layer.shadowColor = UIColor.lightGray.cgColor
        labelView.layer.shadowOpacity = 0.8
        labelView.layer.shadowRadius = 10
        labelView.layer.shadowOffset = FunctionsViewController.shadowViewShadowOffset
        
        return labelView
    }()
    
    lazy var titleLabel: UIEdgeInsetsLabel = {
        let label = UIEdgeInsetsLabel(
            top: FunctionsViewController.inset,
            left: FunctionsViewController.inset,
            bottom: FunctionsViewController.inset,
            right: FunctionsViewController.inset
        )
        titieLabelShadowView.addSubview(label)
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.text = lesson.title
        label.numberOfLines = 0
        label.font = FunctionsViewController.titleLabelFont
        
        return label
    }()
    
    lazy var functionTableShadowView: UIView = {
        let labelView = UIView()
        view.addSubview(labelView)
        labelView.layer.shadowColor = UIColor.lightGray.cgColor
        labelView.layer.shadowOpacity = 0.8
        labelView.layer.shadowRadius = 10
        labelView.layer.shadowOffset = FunctionsViewController.shadowViewShadowOffset
            
        return labelView
    }()
    
    lazy var functionTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        functionTableShadowView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
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
        
        view.backgroundColor = .white
        
        lessonLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.23)
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.39)
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
        
        functionTableShadowView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titieLabelShadowView.snp.bottom).offset(UIScreen.main.bounds.height * 0.025)
            make.height.equalTo(FunctionsViewController.tableViewrowHeight * 5)
            make.width.equalTo(titieLabelShadowView.snp.width)
        }
        functionTableView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.98)
            make.height.equalTo(FunctionsViewController.tableViewrowHeight * 5)
        }
    }
    
    func updateValues(lesson: Lesson, delegate: LessonViewController) {
        self.lesson = lesson
        
        self.delegate = delegate
    }
    
    // MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellLabelDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: FunctionsViewController.functionCellReuseIdentifier) as! FunctionTableViewCell
        let cell = UITableViewCell(style: .default, reuseIdentifier: FunctionsViewController.functionCellReuseIdentifier)
        cell.textLabel?.text = cellLabelDict[indexPath.row]
        cell.imageView?.image = cellImageViewDict[indexPath.row]
        cell.imageView?.image = cell.imageView?.image!.scale(to: 0.5)
        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: delegate.learningButtonTapped(lesson: lesson)
        case 1: delegate.vocabButtonTapped(lesson: lesson)
        case 2: delegate.sentencesButtonTapped(lesson: lesson)
        case 3: delegate.readingButtonTapped(lesson: lesson)
        case 4: delegate.testButtonTapped(lesson: lesson)
        default: return
        }
    }
}

extension FunctionsViewController {
    static let functionCellReuseIdentifier = "FunctionTableViewCell"
    static let tableViewEstimatedRowHeight: CGFloat = UIScreen.main.bounds.height * 0.145
    static let tableViewrowHeight: CGFloat = UIScreen.main.bounds.height * 0.090
}

extension FunctionsViewController {
    static let shadowViewShadowOffset: CGSize = CGSize(width: UIScreen.main.bounds.width * 0.01, height: UIScreen.main.bounds.height * 0.006)
    static let titleLabelFont: UIFont = UIFont.systemFont(ofSize: UIScreen.main.bounds.width * 0.05)
    static let inset = UIScreen.main.bounds.width * 0.02
}

protocol FunctionsViewControllerDelegate {
    func learningButtonTapped(lesson: Lesson)
    func vocabButtonTapped(lesson: Lesson)
    func sentencesButtonTapped(lesson: Lesson)
    func readingButtonTapped(lesson: Lesson)
    func testButtonTapped(lesson: Lesson)
}
