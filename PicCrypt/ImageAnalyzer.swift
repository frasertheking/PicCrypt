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
    
    func colorArray() -> [UIColor] {
        let result = NSMutableArray()
        
        // First get width of number squares
        var width : Int = 0
        while (true) {
            width += 1
            let color = self.getPixelColor(pos: CGPoint(x: 10, y: 10 + width))
            if (color == UIColor(red: 0, green: 0, blue: 0, alpha: 1)) {
                break
            }
        }
        
        // Now get number of objects
        var numberResult : String = ""
        var numCountY : Int = 0
        width = width + 20
        let myOffset = width / 2
        while (true) {
            let inColor : UIColor = CustomColors.getClosestColor(color: self.getPixelColor(pos: CGPoint(x: width/2, y: width * numCountY + myOffset)), number: true)
            let outColor : UIColor = CustomColors.getOuterColor(color: self.getPixelColor(pos: CGPoint(x: 3, y: width * numCountY + myOffset)))

            if (CustomColors.getClosestColor(color: inColor, number: true) == CustomColors.spColor) {
                break
            }
            
            numberResult += CharColor.colorToChar(innerColor: inColor, outerColor: outColor)
            numCountY += 1
        }
        
        print(numberResult)
        
        var countX : Int = 0
        var countY : Int = 0
        
        let amount = self.cgImage!.width == 500 ? 50 : 25
        let offset = self.cgImage!.width == 500 ? 25 : 12
        
        while (countX < self.cgImage!.width / amount) {
            while (countY < self.cgImage!.height / amount) {
                result.add(self.getPixelColor(pos: CGPoint(x: countX * amount + offset, y: countY * amount + offset)))
                countY += 1
            }
            countX += 1
            countY = 0
        }
        
        return (result as NSArray) as! [UIColor]
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
