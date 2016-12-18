//
//  ViewController.swift
//  PicCrypt
//
//  Created by Fraser King on 2016-12-10.
//  Copyright © 2016 Fraser King. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cryptView: CryptView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func takeScreenshot(sender: UIButton) {
        let image = cryptView?.takeScreenShot()
        let colorArray = image?.colorArray()
        
      //  print(CharColor.colorToChar(color: (image?.getPixelColor(pos: CGPoint(x: 10, y: 10)))!))
        
        for color in colorArray! {
            let closeColor = CustomColors.getClosestColor(color: color)
            print(CharColor.colorToChar(color: closeColor), terminator:"")
        }
    }
}

