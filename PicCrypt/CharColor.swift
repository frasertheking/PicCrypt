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
        switch character {
        case "a":
            return CustomColors.aColor
        case "b":
            return CustomColors.bColor
        case "c":
            return CustomColors.cColor
        case "d":
            return CustomColors.dColor
        case "e":
            return CustomColors.eColor
        case "f":
            return CustomColors.fColor
        case "g":
            return CustomColors.gColor
        case "h":
            return CustomColors.hColor
        case "i":
            return CustomColors.iColor
        case "j":
            return CustomColors.jColor
        case "k":
            return CustomColors.kColor
        case "l":
            return CustomColors.lColor
        case "m":
            return CustomColors.mColor
        case "n":
            return CustomColors.nColor
        case "o":
            return CustomColors.oColor
        case "p":
            return CustomColors.pColor
        case "q":
            return CustomColors.qColor
        case "r":
            return CustomColors.rColor
        case "s":
            return CustomColors.sColor
        case "t":
            return CustomColors.tColor
        case "u":
            return CustomColors.uColor
        case "v":
            return CustomColors.vColor
        case "w":
            return CustomColors.wColor
        case "x":
            return CustomColors.xColor
        case "y":
            return CustomColors.yColor
        case "z":
            return CustomColors.zColor
        case " ":
            return CustomColors.spColor
        default:
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
        case CustomColors.spColor:
            return " "
        case UIColor.white:
            return ""
        default:
            return "?"
        }
    }
}

