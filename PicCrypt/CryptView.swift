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
            updatePattern(message: text!)
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
        
        var offsetX: Int = 0
        var offsetY: Int = 0
        for char in message.characters {
            let squareView = UIView(frame: CGRect(x: 25*offsetX, y: 25*offsetY, width: 25, height: 25))
            squareView.backgroundColor = CharColor.charToColor(character: "\(char)")
            squareView.tag = offsetX + offsetY
            squareView.alpha = 0
            squareView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            let ringView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            ringView.layer.borderWidth = 5
            
            if (char == "0" || char == "1" || char == "2" || char == "3" || char == "4" || char == "5" || char == "6" || char == "7" || char == "8" || char == "9") {
                ringView.layer.borderColor = UIColor.white.cgColor
                squareView.addSubview(ringView)
            }
            
            self.addSubview(squareView)
            offsetX += 1
            if (offsetX == 10) {
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
                grid.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { finish in
                UIView.animate(withDuration: 0.2){
                    grid.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            })
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
