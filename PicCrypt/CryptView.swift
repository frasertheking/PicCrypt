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
        genericInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        genericInit()
    }
    
    func genericInit() {
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func updatePattern(message: String) {

        var offsetX: Int = 0
        var offsetY: Int = 0
        for char in message.characters {
            let squareView = UIView(frame: CGRect(x: 25*offsetX, y: 25*offsetY, width: 25, height: 25))
            squareView.backgroundColor = CharColor.charToColor(character: "\(char)")
            self.addSubview(squareView)
            offsetX += 1
            if (offsetX == 10) {
                offsetY += 1
                offsetX = 0
            }
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
