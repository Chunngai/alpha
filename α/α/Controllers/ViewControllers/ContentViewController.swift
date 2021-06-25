//
//  LearningViewController.swift
//  α
//
//  Created by Sola on 2021/1/16.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit
import SnapKit
import PDFKit

class ContentViewController: UIViewController {

    var document: PDFDocument!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func updateViews() {
        let pdfView = PDFView(frame: view.frame)  // Don't use snapkit here!
        view.addSubview(pdfView)
        
        pdfView.document = document
        pdfView.autoScales = true
        pdfView.maxScaleFactor = 4.0
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        pdfView.displayMode = .singlePageContinuous
        pdfView.displaysPageBreaks = true
    }
    
    func updateValues(lessonId: Int) {
        guard let url = Bundle.main.url(forResource: "lesson\(lessonId)", withExtension: "pdf") else { return }
        guard let doc = PDFDocument(url: url) else { return }
        document = doc
    }
}
