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

class PDFViewController: UIViewController {

    var document: PDFDocument!
    
    // MARK: - Views
    
    lazy var pdfView: PDFView = {
        let pdfView = PDFView(frame: view.frame)  // Don't use snapkit here!
        view.addSubview(pdfView)
        
        pdfView.document = document
        pdfView.autoScales = true
        pdfView.maxScaleFactor = 4.0
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        pdfView.displayMode = .singlePageContinuous
        pdfView.displaysPageBreaks = true
        
        return pdfView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func updateViews() {
        navigationItem.largeTitleDisplayMode = .never
        
        // TODO: - how to display the pdf view wo the pring statement here?
        // TODO: - or use snapkit here?
        print(pdfView)
    }
    
    func updateValues(fileName: String) {
        guard let url = Bundle.main.url(forResource: "\(fileName)", withExtension: "pdf") else { return }
        guard let doc = PDFDocument(url: url) else { return }
        document = doc
    }
}
