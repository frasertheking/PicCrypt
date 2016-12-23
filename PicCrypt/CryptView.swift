//
//  TextToPic.swift
//  PicCrypt
//
//  Created by Fraser King on 2016-12-10.
//  Copyright © 2016 Fraser King. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CryptView: UIView {
    @IBInspectable var text: String?  {
        didSet {
            updatePattern(message: "\(text!.characters.count) " + text!)
        }
    }
    @IBInspectable var viewBackgroundColor: UIColor? {
        didSet {
            layer.backgroundColor = viewBackgroundColor?.cgColor
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func updatePattern(message: String) {

        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        let messageLen = message.characters.count
        var offsetX: Int = 0
        var offsetY: Int = 0
        for char in message.characters {
            let charStr = "\(char)"
            
            let x : Double = 300
            let y : Double = 300
            let n : Double = Double(messageLen)
            let px = ceil(sqrt(Double(n * x / y)))
            var sx : Double
            if (floor(px * y / x) * px < n) {
                sx = y / ceil(px*y/x)
            } else {
                sx = x / px
            }
            
            let squareSize : Int = Int(floor(sx))
            
            let squareView = UIView(frame: CGRect(x: squareSize*offsetX, y: squareSize*offsetY, width: squareSize, height: squareSize))
            squareView.backgroundColor = CharColor.charToColor(character: charStr)
            squareView.tag = offsetX + offsetY
            squareView.alpha = 0
            squareView.layer.masksToBounds = true
            let ringView = UIView(frame: CGRect(x: 0, y: 0, width: squareSize, height: squareSize))
            ringView.layer.borderWidth = 5
            
            if (char == "0" || char == "1" || char == "2" || char == "3" || char == "4" || char == "5" || char == "6" || char == "7" || char == "8" || char == "9") {
                ringView.layer.borderColor = UIColor.gray.cgColor
                squareView.addSubview(ringView)
            } else if (char == "+" || char == "/") {
                ringView.layer.borderColor = UIColor.black.cgColor
                squareView.addSubview(ringView)
            } else if (charStr.isLowercase()) {
                ringView.layer.borderColor = UIColor.white.cgColor
                squareView.addSubview(ringView)
            }
            
            self.addSubview(squareView)
            offsetX += 1
            if (offsetX == Int(floor(Double(300 / squareSize)))) {
                offsetY += 1
                offsetX = 0
            }
        }
        showGrid()
    }

    func showGrid() {
        
        for grid in self.subviews {
            let randDelay = CGFloat(Float(arc4random()) / Float(UINT32_MAX))

            UIView.animate(withDuration: 0.2, delay: TimeInterval(randDelay), options: UIViewAnimationOptions(rawValue: 0), animations: {
                grid.alpha = 1
            }, completion: nil)
        }
    }
    
    func takeScreenShot() -> UIImage {
        let rendererFormat = UIGraphicsImageRendererFormat.default()
        rendererFormat.opaque = isOpaque
        let renderer = UIGraphicsImageRenderer(size: bounds.size, format: rendererFormat)
        
        let snapshotImage = renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        return snapshotImage
    }
}
