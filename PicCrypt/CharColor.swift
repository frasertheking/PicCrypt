//
//  CharColor.swift
//  PicCrypt
//
//  Created by Fraser King on 2016-12-10.
//  Copyright © 2016 Fraser King. All rights reserved.
//

import Foundation
import UIKit

class CharColor {

    class func charToColor(character: String) -> UIColor {
        if (character == "a" || character == "A") {
            return CustomColors.aColor
        } else if (character == "b" || character == "B") {
            return CustomColors.bColor
        } else if (character == "c" || character == "C") {
            return CustomColors.cColor
        } else if (character == "d" || character == "D") {
            return CustomColors.dColor
        } else if (character == "e" || character == "E") {
            return CustomColors.eColor
        } else if (character == "f" || character == "F") {
            return CustomColors.fColor
        } else if (character == "g" || character == "G") {
            return CustomColors.gColor
        } else if (character == "h" || character == "H") {
            return CustomColors.hColor
        } else if (character == "i" || character == "I") {
            return CustomColors.iColor
        } else if (character == "j" || character == "J") {
            return CustomColors.jColor
        } else if (character == "k" || character == "K") {
            return CustomColors.kColor
        } else if (character == "l" || character == "L") {
            return CustomColors.lColor
        } else if (character == "m" || character == "M") {
            return CustomColors.mColor
        } else if (character == "n" || character == "N") {
            return CustomColors.nColor
        } else if (character == "o" || character == "O") {
            return CustomColors.oColor
        } else if (character == "p" || character == "P") {
            return CustomColors.pColor
        } else if (character == "q" || character == "Q") {
            return CustomColors.qColor
        } else if (character == "r" || character == "R") {
            return CustomColors.rColor
        } else if (character == "s" || character == "S") {
            return CustomColors.sColor
        } else if (character == "t" || character == "T") {
            return CustomColors.tColor
        } else if (character == "u" || character == "U") {
            return CustomColors.uColor
        } else if (character == "v" || character == "V") {
            return CustomColors.vColor
        } else if (character == "w" || character == "W") {
            return CustomColors.wColor
        } else if (character == "x" || character == "X") {
            return CustomColors.xColor
        } else if (character == "y" || character == "Y") {
            return CustomColors.yColor
        } else if (character == "z" || character == "Z") {
            return CustomColors.zColor
        } else if (character == "0") {
            return CustomColors.color0
        } else if (character == "1") {
            return CustomColors.color1
        } else if (character == "2") {
            return CustomColors.color2
        } else if (character == "3") {
            return CustomColors.color3
        } else if (character == "4") {
            return CustomColors.color4
        } else if (character == "5") {
            return CustomColors.color5
        } else if (character == "6") {
            return CustomColors.color6
        } else if (character == "7") {
            return CustomColors.color7
        } else if (character == "8") {
            return CustomColors.color8
        } else if (character == "9") {
            return CustomColors.color9
        } else if (character == "+") {
            return CustomColors.colorPlus
        } else if (character == "/") {
            return CustomColors.colorSlash
        } else if (character == "=") {
            return CustomColors.colorEquals
        } else if (character == " ") {
            return CustomColors.spColor
        } else {
            return UIColor.white
        }
}
    
    class func colorToChar(color: UIColor) -> String {
        switch color {
        case CustomColors.aColor:
            return "a"
        case CustomColors.bColor:
            return "b"
        case CustomColors.cColor:
            return "c"
        case CustomColors.dColor:
            return "d"
        case CustomColors.eColor:
            return "e"
        case CustomColors.fColor:
            return "f"
        case CustomColors.gColor:
            return "g"
        case CustomColors.hColor:
            return "h"
        case CustomColors.iColor:
            return "i"
        case CustomColors.jColor:
            return "j"
        case CustomColors.kColor:
            return "k"
        case CustomColors.lColor:
            return "l"
        case CustomColors.mColor:
            return "m"
        case CustomColors.nColor:
            return "n"
        case CustomColors.oColor:
            return "o"
        case CustomColors.pColor:
            return "p"
        case CustomColors.qColor:
            return "q"
        case CustomColors.rColor:
            return "r"
        case CustomColors.sColor:
            return "s"
        case CustomColors.tColor:
            return "t"
        case CustomColors.uColor:
            return "u"
        case CustomColors.vColor:
            return "v"
        case CustomColors.wColor:
            return "w"
        case CustomColors.xColor:
            return "x"
        case CustomColors.yColor:
            return "y"
        case CustomColors.zColor:
            return "z"
        case CustomColors.color0:
            return "0"
        case CustomColors.color1:
            return "1"
        case CustomColors.color2:
            return "2"
        case CustomColors.color3:
            return "3"
        case CustomColors.color4:
            return "4"
        case CustomColors.color5:
            return "5"
        case CustomColors.color6:
            return "6"
        case CustomColors.color7:
            return "7"
        case CustomColors.color8:
            return "8"
        case CustomColors.color9:
            return "9"
        case CustomColors.colorPlus:
            return "+"
        case CustomColors.colorSlash:
            return "/"
        case CustomColors.spColor:
            return " "
        case UIColor.white:
            return ""
        default:
            return "?"
        }
    }
}

