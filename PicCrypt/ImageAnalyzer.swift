//
//  ImageAnalyzer.swift
//  PicCrypt
//
//  Created by Fraser King on 2016-12-15.
//  Copyright © 2016 Fraser King. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func colorString() -> String {
        
        let width = extractWidth()
        var numberResult = extractNumber(width: width)
        
        var result = ""
        let squareSize = UIImage.getSquareSize(len: Int(numberResult)! + numberResult.characters.count)
        var countX : Int = 0
        var countY : Int = numberResult.characters.count + 1
        
        let amount = squareSize*2
        let offset = squareSize
        
        while (countX < self.cgImage!.width / amount) {
            while (countY < self.cgImage!.height / amount) {
                let color1 : UIColor = self.getPixelColor(pos: CGPoint(x: countX * amount + offset, y: countY * amount + offset))
                let color2 : UIColor = self.getPixelColor(pos: CGPoint(x: countX * amount + 2, y: countY * amount + offset))
                if (color1 == color2) {
                    result += (CharColor.colorToChar(innerColor: CustomColors.getClosestColor(color: color1, number: false), outerColor: nil))
                } else if (CustomColors.getOuterColor(color: color2) == UIColor.white) {
                    result += (CharColor.colorToChar(innerColor: CustomColors.getClosestColor(color: color1, number: false), outerColor: CustomColors.getOuterColor(color: color2)))
                } else {
                    result += (CharColor.colorToChar(innerColor: CustomColors.getClosestColor(color: color1, number: true), outerColor: CustomColors.getOuterColor(color: color2)))
                }
                
                countY += 1
            }
            countX += 1
            countY = 0
        }
        
        return result
    }
    
    func extractWidth() -> Int {
        var width : Int = 0
        while (true) {
            width += 1
            let color = self.getPixelColor(pos: CGPoint(x: 6, y: 6 + width))
            if (color == UIColor(red: 0, green: 0, blue: 0, alpha: 1)) {
                break
            }
        }
        return width
    }
    
    func extractNumber(width: Int) -> String {
        var numberResult : String = ""
        var numCountY : Int = 0
        let wWidth = width + 12
        let myOffset = wWidth / 2
        while (true) {
            let inColor : UIColor = CustomColors.getClosestColor(color: self.getPixelColor(pos: CGPoint(x: wWidth/2, y: wWidth * numCountY + myOffset)), number: true)
            let outColor : UIColor = CustomColors.getOuterColor(color: self.getPixelColor(pos: CGPoint(x: 2, y: wWidth * numCountY + myOffset)))
            
            if (CustomColors.getClosestColor(color: inColor, number: true) == CustomColors.spColor) {
                break
            }
            
            numberResult += CharColor.colorToChar(innerColor: inColor, outerColor: outColor)
            numCountY += 1
        }
        return numberResult
    }
    
    class func getSquareSize(len: Int) -> Int {
        let x : Double = 300
        let y : Double = 300
        let n : Double = Double(len)
        let px = ceil(sqrt(Double(n * x / y)))
        var sx : Double
        if (floor(px * y / x) * px < n) {
            sx = y / ceil(px*y/x)
        } else {
            sx = x / px
        }
        
        return Int(floor(sx))
    }
    
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let img = self.cgImage
        let width = img!.width
        let height = img!.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var rawData = [UInt8](repeating: 0, count: width * height * 4)
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bytesPerComponent = 8
        
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        let context = CGContext(data: &rawData, width: width, height: height, bitsPerComponent: bytesPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
        
        context?.draw(img!, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let byteIndex = (bytesPerRow * Int(pos.x)) + Int(pos.y) * bytesPerPixel
        
        let red   = CGFloat(rawData[byteIndex]    ) / 255.0
        let green = CGFloat(rawData[byteIndex + 1]) / 255.0
        let blue  = CGFloat(rawData[byteIndex + 2]) / 255.0
        let alpha = CGFloat(rawData[byteIndex + 3]) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
