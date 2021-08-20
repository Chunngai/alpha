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
                
    // MARK: - Views
    
    lazy var titleLabelShadowView: UIView = {
        let labelView = UIView()
        view.addSubview(labelView)
        
        labelView.layer.shadowColor = UIColor.lightGray.cgColor
        labelView.layer.shadowOpacity = MenuViewController.shadowOpacity
        labelView.layer.shadowRadius = MenuViewController.shadowRadius
        labelView.layer.shadowOffset = MenuViewController.shadowOffset
        
        return labelView
    }()
    
    lazy var titleLabel: PaddingLabel = {
        let label = PaddingLabel(padding: MenuViewController.titleInset)
        titleLabelShadowView.addSubview(label)
        
        label.backgroundColor = .white
        label.textColor = Theme.textColor
        label.textAlignment = .center
        label.layer.cornerRadius = MenuViewController.titleCornerRadius
        label.layer.masksToBounds = true
        label.text = lesson.title
        label.numberOfLines = 0
        label.font = Theme.headlineFont
        
        return label
    }()
    
    lazy var lessonLabel: UILabel = {
        let label = UILabel()
        titleLabel.addSubview(label)
        
        label.backgroundColor = Theme.lightBlue
        label.textColor = Theme.textColor
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
        labelView.layer.shadowOpacity = MenuViewController.shadowOpacity
        labelView.layer.shadowRadius = MenuViewController.shadowRadius
        labelView.layer.shadowOffset = MenuViewController.shadowOffset
            
        return labelView
    }()
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        menuTableShadowView.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = MenuViewController.tableCornerRadius
        tableView.rowHeight = MenuViewController.tableRowHeight
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
        view.backgroundColor = Theme.backgroundColor
        
        lessonLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.23)
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.39)
        }
        
        titleLabelShadowView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            // https://stackoverflow.com/questions/67749841/how-to-account-for-the-height-of-the-navigation-bar-in-snapkit
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalToSuperview().multipliedBy(0.26)
            make.width.equalToSuperview().multipliedBy(0.89)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.98)
            make.height.equalToSuperview().multipliedBy(0.95)
        }
        
        menuTableShadowView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabelShadowView.snp.bottom).offset(22)
            make.height.equalTo(MenuViewController.tableRowHeight * CGFloat(rowNumber))
            make.width.equalTo(titleLabelShadowView.snp.width)
        }
        menuTableView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(titleLabel.snp.width)
            make.height.equalTo(menuTableShadowView)
        }
    }
    
    func updateValues(lesson: Lesson) {
        self.lesson = lesson
        prepareForDrawingTable()
    }
}

extension MenuViewController {
    // MARK: - Utils
    
    func prepareForDrawingTable() {
        var index: Int {
            return rowNumber - 1
        }
        
        rowNumber += 1
        cellLabelDict[index] = MenuViewController.labels[0]
        cellImageViewDict[index] = MenuViewController.images[0]
        actions.append(learningButtonTapped)

        if lesson.vocab != nil {
            rowNumber += 1
            cellLabelDict[index] = MenuViewController.labels[1]
            cellImageViewDict[index] = MenuViewController.images[1]
            actions.append(vocabButtonTapped)
        }
        
        if lesson.sentences != nil {
            rowNumber += 1
            cellLabelDict[index] = MenuViewController.labels[2]
            cellImageViewDict[index] = MenuViewController.images[2]
            actions.append(sentencesButtonTapped)
        }
        
        if lesson.reading != nil {
            rowNumber += 1
            cellLabelDict[index] = MenuViewController.labels[3]
            cellImageViewDict[index] = MenuViewController.images[3]
            actions.append(readingButtonTapped)
        }
        
        if lesson.sentences != nil {
            rowNumber += 1
            cellLabelDict[index] = MenuViewController.labels[4]
            cellImageViewDict[index] = MenuViewController.images[4]
            actions.append(testButtonTapped)
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: MenuViewController.cellReuseIdentifier)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = Theme.textColor
        cell.textLabel?.text = cellLabelDict[indexPath.row]
        cell.imageView?.image = cellImageViewDict[indexPath.row]?.scale(to: 0.4)
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
    // MARK: - Functions
    
    func learningButtonTapped(lesson: Lesson) {
        let learningViewController = PDFViewController()
        learningViewController.updateValues(fileName: lesson.pdfName)
        navigationController?.pushViewController(learningViewController, animated: true)
    }
    
    func vocabButtonTapped(lesson: Lesson) {
        guard lesson.vocab != nil && lesson.vocab!.count > 0 else { return }
        
        let vocabViewController = TextViewController()
        vocabViewController.updateValues(vocab: lesson.vocab!)
        navigationController?.pushViewController(vocabViewController, animated: true)
    }
    
    func sentencesButtonTapped(lesson: Lesson) {
        guard lesson.sentences != nil && lesson.sentences!.count > 0 else { return }
        
        let sentencesViewController = TextViewController()
        sentencesViewController.updateValues(sentences: lesson.sentences!)
        navigationController?.pushViewController(sentencesViewController, animated: true)
    }
    
    func readingButtonTapped(lesson: Lesson) {
        guard lesson.reading != nil else { return }
        
        let readingViewController = ReadingViewController()
        readingViewController.updateValues(reading: lesson.reading!)
        navigationController?.pushViewController(readingViewController, animated: true)
    }
    
    func testButtonTapped(lesson: Lesson) {
        guard lesson.sentences != nil && lesson.sentences!.count > 0 else { return }
        
        let testViewController = TestViewController()
        testViewController.updateValues(sentences: lesson.sentences!)
        navigationController?.pushViewController(testViewController, animated: true)
    }
}

extension MenuViewController {
    static let shadowOffset: CGSize = CGSize(width: 1, height: 1)
    static let shadowOpacity: Float = 0.3
    static let shadowRadius: CGFloat = 10
    
    static let titleInset = 10
    static let titleCornerRadius: CGFloat = 10
    
    static let cellReuseIdentifier = "MenuTableViewCell"
    static let tableRowHeight: CGFloat = 80
    static let tableCornerRadius: CGFloat = 15
    
    static let labels = [
        "Learning",
        "Vocabulary",
        "Sentences",
        "Reading",
        "Test"
    ]
    static let images = [
        0: UIImage(imageLiteralResourceName: "learning_icon").setColor(color: Theme.lightBlueForIcon),
        1: UIImage(imageLiteralResourceName: "vocab_icon").setColor(color: Theme.lightBlueForIcon),
        2: UIImage(imageLiteralResourceName: "sentences_icon").setColor(color: Theme.lightBlueForIcon),
        3: UIImage(imageLiteralResourceName: "reading_icon").setColor(color: Theme.lightBlueForIcon),
        4: UIImage(imageLiteralResourceName: "test_icon").setColor(color: Theme.lightBlueForIcon)
    ]
}
