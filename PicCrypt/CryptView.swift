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
            updatePattern(message: "\(text!.characters.count) " + text! + "R5b0u")
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
            let squareSize = UIImage.getSquareSize(len: messageLen)
            
            let squareView = UIView(frame: CGRect(x: squareSize*offsetX, y: squareSize*offsetY, width: squareSize, height: squareSize))
            squareView.backgroundColor = CharColor.charToColor(character: charStr)
            squareView.tag = offsetX + offsetY
            squareView.alpha = 0
            squareView.layer.masksToBounds = true
            let ringView = UIView(frame: CGRect(x: 0, y: 0, width: squareSize, height: squareSize))
            ringView.layer.borderWidth = 3
            squareView.transform = CGAffineTransform(scaleX: 0, y: 0)

            if self.isNumeric(char: char) {
                ringView.layer.borderColor = UIColor.black.cgColor
                squareView.addSubview(ringView)
            } else if (char == "+" || char == "/" || char == "=") {
                ringView.layer.borderColor = UIColor.gray.cgColor
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
        //Timer.scheduledTimer(timeInterval: TimeInterval(10), target: self, selector: #selector(CryptView.pulse), userInfo: nil, repeats: true)
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
    
    func pulse() {
        for grid in self.subviews {
            self.bringSubview(toFront: grid)
            let randDelay = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            UIView.animate(withDuration: 0.35, delay: TimeInterval(randDelay), options: UIViewAnimationOptions(rawValue: 0), animations: {
                grid.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.25, delay: TimeInterval(randDelay), options: UIViewAnimationOptions(rawValue: 0), animations: {
                    grid.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: { (finished) in
                    self.sendSubview(toBack: grid)
                })
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
    
    func isNumeric(char: Character) -> Bool {
        if (char == "0" || char == "1" || char == "2" || char == "3" || char == "4" || char == "5" || char == "6" || char == "7" || char == "8" || char == "9") {
            return true
        }
        return false
    }
}
