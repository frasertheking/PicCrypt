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
        
        var countX : Int = 0
        var countY : Int = 0
        
        while (countX < self.cgImage!.width / 50) {
            while (countY < self.cgImage!.height / 50) {
                //print("X \(countX) Y \(countY)")
                result.add(self.getPixelColor(pos: CGPoint(x: countX * 50, y: countY * 50)))
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
