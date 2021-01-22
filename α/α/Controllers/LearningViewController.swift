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

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let path = Bundle.main.url(forResource: "Anne H. Groton From Alpha to Omega A Beginning Course in Classical Greek  2013", withExtension: "pdf") else { return }
        
        let pdfView = PDFView(frame: view.frame)  // Don't use snapkit here!
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
        pdfView.autoScales = true
        pdfView.maxScaleFactor = 4.0
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        pdfView.displayMode = .singlePageContinuous
        pdfView.displaysPageBreaks = true
        view.addSubview(pdfView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
