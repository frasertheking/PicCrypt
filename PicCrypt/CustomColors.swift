//
//  CustomColors.swift
//  PicCrypt
//
//  Created by Fraser King on 2016-12-10.
//  Copyright © 2016 Fraser King. All rights reserved.
//

import Foundation
import UIKit

class CustomColors {
    static let aColor: UIColor = UIColor(red: 0/255, green: 0/255, blue: 180/255, alpha: 1);
    static let bColor: UIColor = UIColor(red: 175/255, green: 13/255, blue: 102/255, alpha: 1);
    static let cColor: UIColor = UIColor(red: 146/255, green: 248/255, blue: 70/255, alpha: 1);
    static let dColor: UIColor = UIColor(red: 255/255, green: 200/255, blue: 47/255, alpha: 1);
    static let eColor: UIColor = UIColor(red: 255/255, green: 118/255, blue: 0/255, alpha: 1);
    static let fColor: UIColor = UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1);
    static let gColor: UIColor = UIColor(red: 235/255, green: 235/255, blue: 222/255, alpha: 1);
    static let hColor: UIColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1);
    static let iColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1);
    static let jColor: UIColor = UIColor(red: 55/255, green: 19/255, blue: 112/255, alpha: 1);
    static let kColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 150/255, alpha: 1);
    static let lColor: UIColor = UIColor(red: 202/255, green: 62/255, blue: 94/255, alpha: 1);
    static let mColor: UIColor = UIColor(red: 205/255, green: 145/255, blue: 63/255, alpha: 1);
    static let nColor: UIColor = UIColor(red: 12/255, green: 75/255, blue: 100/255, alpha: 1);
    static let oColor: UIColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1);
    static let pColor: UIColor = UIColor(red: 175/255, green: 155/255, blue: 50/255, alpha: 1);
    static let qColor: UIColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1);
    static let rColor: UIColor = UIColor(red: 37/255, green: 70/255, blue: 25/255, alpha: 1);
    static let sColor: UIColor = UIColor(red: 121/255, green: 33/255, blue: 135/255, alpha: 1);
    static let tColor: UIColor = UIColor(red: 83/255, green: 140/255, blue: 208/255, alpha: 1);
    static let uColor: UIColor = UIColor(red: 0/255, green: 154/255, blue: 37/255, alpha: 1);
    static let vColor: UIColor = UIColor(red: 178/255, green: 220/255, blue: 205/255, alpha: 1);
    static let wColor: UIColor = UIColor(red: 255/255, green: 152/255, blue: 213/255, alpha: 1);
    static let xColor: UIColor = UIColor(red: 0/255, green: 0/255, blue: 74/255, alpha: 1);
    static let yColor: UIColor = UIColor(red: 175/255, green: 200/255, blue: 74/255, alpha: 1);
    static let zColor: UIColor = UIColor(red: 63/255, green: 25/255, blue: 12/255, alpha: 1);
    static let spColor: UIColor = UIColor(red: 22/255, green: 47/255, blue: 70/255, alpha: 1);
    
    static let colorArray = [aColor, bColor, cColor, dColor, eColor, fColor, gColor, hColor,
                      iColor, jColor, kColor, lColor, mColor, nColor, oColor, pColor,
                      qColor, rColor, sColor, tColor, uColor, vColor, wColor, xColor,
                      yColor, zColor, spColor]
    
    class func getClosestColor(color: UIColor) -> UIColor {
        var min : CGFloat?
        var closestColor : UIColor?
        var count : Int = 0
        for letterColor in colorArray {
            if (color == UIColor(red: 1, green: 1, blue: 1, alpha: 1)) {
                return UIColor.white
            }
            
            let sumSquareDiff : CGFloat = (CGFloat(pow(((color.cgColor.components?[0])! - (letterColor.cgColor.components?[0])!), 2)) +
                                 CGFloat(pow(((color.cgColor.components?[1])! - (letterColor.cgColor.components?[1])!), 2)) +
                                 CGFloat(pow(((color.cgColor.components?[2])! - (letterColor.cgColor.components?[2])!), 2)))

            if ((min == nil) || sumSquareDiff < min!) {
                min = sumSquareDiff
                closestColor = letterColor
            }
            count += 1
        }
        
        return closestColor!
    }
}
