//
//  FunctionSelectionViewController.swift
//  α
//
//  Created by Sola on 2021/1/16.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var rowNumber: Int = 0
    var cellLabelDict: [Int: String] = [:]
    var cellImageViewDict: [Int: UIImage] = [:]
    var actions: [(Lesson) -> ()] = []
        
    // MARK: - Models
    
    var lesson: Lesson!
    
    // MARK: - Controllers
        
    var delegate: HomeViewController!
    
    // MARK: - Views
    
    lazy var titieLabelShadowView: UIView = {
        let labelView = UIView()
        view.addSubview(labelView)
        
        labelView.layer.shadowColor = UIColor.lightGray.cgColor
        labelView.layer.shadowOpacity = 0.8
        labelView.layer.shadowRadius = 10
        labelView.layer.shadowOffset = MenuViewController.shadowOffset
        
        return labelView
    }()
    
    lazy var titleLabel: EdgeInsetsLabel = {
        let label = EdgeInsetsLabel(
            top: MenuViewController.titleLabelinset,
            left: MenuViewController.titleLabelinset,
            bottom: MenuViewController.titleLabelinset,
            right: MenuViewController.titleLabelinset
        )
        titieLabelShadowView.addSubview(label)
        
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.text = lesson.title
        label.numberOfLines = 0
        label.font = MenuViewController.titleLabelFont
        
        return label
    }()
    
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
    
    lazy var menuTableShadowView: UIView = {
        let labelView = UIView()
        view.addSubview(labelView)
        
        labelView.layer.shadowColor = UIColor.lightGray.cgColor
        labelView.layer.shadowOpacity = 0.8
        labelView.layer.shadowRadius = 10
        labelView.layer.shadowOffset = MenuViewController.shadowOffset
            
        return labelView
    }()
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        menuTableShadowView.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 15
        tableView.estimatedRowHeight = MenuViewController.tableViewEstimatedRowHeight
        tableView.rowHeight = MenuViewController.tableViewrowHeight
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
            make.top.equalToSuperview().offset(MenuViewController.titleShadowViewTopOffset)
            make.height.equalTo(MenuViewController.titleShadowViewHeight)
            make.width.equalTo(MenuViewController.titleShadowViewWidth)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.98)
            make.height.equalToSuperview().multipliedBy(0.95)
        }
        
        menuTableShadowView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titieLabelShadowView.snp.bottom).offset(MenuViewController.tableShadowViewOffset)
            make.height.equalTo(MenuViewController.tableViewrowHeight * CGFloat(rowNumber))
            make.width.equalTo(titieLabelShadowView.snp.width)
        }
        menuTableView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.98)
            make.height.equalTo(menuTableShadowView)
        }
    }
    
    func updateValues(lesson: Lesson, delegate: HomeViewController) {
        self.lesson = lesson
        self.delegate = delegate
        prepareForDrawingTable()
    }
    
    // MARK: - Utils
    
    func prepareForDrawingTable() {
        var index: Int {
            return rowNumber - 1
        }
        
        rowNumber += 1
        cellLabelDict[index] = MenuViewController.labels[0]
        cellImageViewDict[index] = MenuViewController.images[0]
        actions.append(delegate.learningButtonTapped)

        if lesson.vocab != nil {
            rowNumber += 1
            cellLabelDict[index] = MenuViewController.labels[1]
            cellImageViewDict[index] = MenuViewController.images[1]
            actions.append(delegate.vocabButtonTapped)
        }
        
        if lesson.sentences != nil {
            rowNumber += 1
            cellLabelDict[index] = MenuViewController.labels[2]
            cellImageViewDict[index] = MenuViewController.images[2]
            actions.append(delegate.sentencesButtonTapped)
        }
        
        if lesson.reading != nil {
            rowNumber += 1
            cellLabelDict[index] = MenuViewController.labels[3]
            cellImageViewDict[index] = MenuViewController.images[3]
            actions.append(delegate.readingButtonTapped)
        }
        
        if lesson.sentences != nil {
            rowNumber += 1
            cellLabelDict[index] = MenuViewController.labels[4]
            cellImageViewDict[index] = MenuViewController.images[4]
            actions.append(delegate.testButtonTapped)
        }
    }
}

extension MenuViewController {
    // MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: MenuViewController.functionCellReuseIdentifier)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .darkGray
        cell.textLabel?.text = cellLabelDict[indexPath.row]
        cell.imageView?.image = cellImageViewDict[indexPath.row]?.scale(to: 0.5)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MenuViewController {
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actions[indexPath.row](lesson)
    }
}

extension MenuViewController {
    static let labels = [
        "Learning",
        "Vocabulary",
        "Sentences",
        "Reading",
        "Test"
    ]
    static let images = [
        0: UIImage(imageLiteralResourceName: "learning"),
        1: UIImage(imageLiteralResourceName: "vocab_sents_reading"),
        2: UIImage(imageLiteralResourceName: "vocab_sents_reading"),
        3: UIImage(imageLiteralResourceName: "vocab_sents_reading"),
        4: UIImage(imageLiteralResourceName: "test")
    ]
    
    static let functionCellReuseIdentifier = "MenuTableViewCell"
    static let tableViewEstimatedRowHeight: CGFloat = UIScreen.main.bounds.height * 0.145
    static let tableViewrowHeight: CGFloat = UIScreen.main.bounds.height * 0.090

    
    static let shadowOffset: CGSize = CGSize(width: UIScreen.main.bounds.width * 0.01, height: UIScreen.main.bounds.height * 0.006)
    static let titleLabelFont: UIFont = UIFont.systemFont(ofSize: UIScreen.main.bounds.width * 0.05)
    static let titleLabelinset = UIScreen.main.bounds.width * 0.02
    
    static let titleShadowViewTopOffset = UIScreen.main.bounds.height * 0.12
    static let titleShadowViewHeight = UIScreen.main.bounds.height * 0.25
    static let titleShadowViewWidth = UIScreen.main.bounds.width * 0.9
    static let tableShadowViewOffset = UIScreen.main.bounds.height * 0.025
}

protocol MenuViewControllerDelegate {
    func learningButtonTapped(lesson: Lesson)
    func vocabButtonTapped(lesson: Lesson)
    func sentencesButtonTapped(lesson: Lesson)
    func readingButtonTapped(lesson: Lesson)
    func testButtonTapped(lesson: Lesson)
}
