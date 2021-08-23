//
//  UIScrollView.swift
//  α
//
//  Created by Sola on 2021/8/24.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    func scrollToTop(animated: Bool = true) {
        // https://stackoverflow.com/questions/9450302/get-uiscrollview-to-scroll-to-the-top
        // Note that the left content inset should be taken into consideration.
        let offset = CGPoint(x: -contentInset.left, y: -contentInset.top)
        setContentOffset(offset, animated: animated)
    }
}
