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

class LearningViewController: UIViewController {

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func updateViews() {
        // TODO: Wrap the code here
        guard let path = Bundle.main.url(forResource: "Anne H. Groton From Alpha to Omega A Beginning Course in Classical Greek  2013", withExtension: "pdf") else { return }
        
        let pdfView = PDFView(frame: view.frame)  // Don't use snapkit here!
        view.addSubview(pdfView)
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
        pdfView.autoScales = true
        pdfView.maxScaleFactor = 4.0
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        pdfView.displayMode = .singlePageContinuous
        pdfView.displaysPageBreaks = true
    }
}
