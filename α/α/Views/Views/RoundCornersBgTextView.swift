//
//  RoundCornersBgTextView.swift
//  α
//
//  Created by Sola on 2021/8/18.
//  Copyright © 2021 Sola. All rights reserved.
//

import UIKit

class RoundCornersBgTextView: UITextView {
    
    var shouldCenterVertically: Bool!
    
    // MARK: - Init
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    convenience init(frame: CGRect, textContainerSize: CGSize, shoudCenterVertically: Bool = true) {
        let textStorage = NSTextStorage()
        
        let textLayoutManager = LayoutManagerForRoundedCornersBackground()
        textLayoutManager.cornerRadius = 5
        textStorage.addLayoutManager(textLayoutManager)
        
        let textContainer = NSTextContainer(size: textContainerSize)
        textLayoutManager.addTextContainer(textContainer)
        
        self.init(frame: frame, textContainer: textContainer)
        
        self.shouldCenterVertically = shoudCenterVertically
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shouldCenterVertically {
            centerVertically()
        }
    }
    
}

extension RoundCornersBgTextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}

extension RoundCornersBgTextView {
    func scrollToTop(animated: Bool = true) {
        // https://stackoverflow.com/questions/9450302/get-uiscrollview-to-scroll-to-the-top
        // Note that the left content inset should be taken into consideration.
        let offset = CGPoint(x: -contentInset.left, y: -contentInset.top)
        setContentOffset(offset, animated: animated)
   }
}

class LayoutManagerForRoundedCornersBackground: NSLayoutManager {
    
    var cornerRadius: CGFloat = LayoutManagerForRoundedCornersBackground.defaultCornerRadius
    
    override func fillBackgroundRectArray(_ rectArray: UnsafePointer<CGRect>, count rectCount: Int, forCharacterRange charRange: NSRange, color: UIColor) {
        let path = CGMutablePath.init()
        
        if rectCount == 1 || (rectCount == 2 && (rectArray[1].maxX < rectArray[0].maxX)) {
            path.addRect(rectArray[0].insetBy(dx: cornerRadius, dy: cornerRadius))
            if rectCount == 2 {
                path.addRect(rectArray[1].insetBy(dx: cornerRadius, dy: cornerRadius))
            }
        } else {
            let lastRect = rectCount - 1
            
            path.move(to: CGPoint(
                x: rectArray[0].minX + cornerRadius,
                y: rectArray[0].maxY + cornerRadius
            ))
            
            path.addLine(to: CGPoint(
                x: rectArray[0].minX + cornerRadius,
                y: rectArray[0].minY + cornerRadius
            ))
            path.addLine(to: CGPoint(
                x: rectArray[0].maxX - cornerRadius,
                y: rectArray[0].minY + cornerRadius
            ))
            
            path.addLine(to: CGPoint(
                x: rectArray[0].maxX - cornerRadius,
                y: rectArray[lastRect].minY - cornerRadius
            ))
            path.addLine(to: CGPoint(
                x: rectArray[lastRect].maxX - cornerRadius,
                y: rectArray[lastRect].minY - cornerRadius
            ))
            
            path.addLine(to: CGPoint(
                x: rectArray[lastRect].maxX - cornerRadius,
                y: rectArray[lastRect].maxY - cornerRadius
            ))
            path.addLine(to: CGPoint(
                x: rectArray[lastRect].minX + cornerRadius,
                y: rectArray[lastRect].maxY - cornerRadius
            ))
            
            path.addLine(to: CGPoint(
                x: rectArray[lastRect].minX + cornerRadius,
                y: rectArray[0].maxY + cornerRadius
            ))
            
            path.closeSubpath()
            
        }
        
        color.set()
        
        let ctx = UIGraphicsGetCurrentContext()
//        ctx!.setLineWidth(cornerRadius * 2.0)
        ctx!.setLineWidth(cornerRadius * 1.2)
        ctx!.setLineJoin(.round)
        
        ctx!.setAllowsAntialiasing(true)
        ctx!.setShouldAntialias(true)
        
        ctx!.addPath(path)
        ctx!.drawPath(using: .fillStroke)
    }
}

extension LayoutManagerForRoundedCornersBackground {
    static let defaultCornerRadius: CGFloat = 5
}
