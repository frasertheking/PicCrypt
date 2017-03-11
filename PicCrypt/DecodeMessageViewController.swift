//
//  DecodeMessageViewController.swift
//  PicCrypt
//
//  Created by Fraser King on 2017-03-11.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import Foundation
import UIKit

class DecodeMessageViewController: UIViewController {

    @IBOutlet private weak var cryptImageView: UIImageView!
    @IBOutlet private weak var decodedMessageLabel: UILabel!
    var imageURL : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cryptImageView.sd_setImage(with: URL(string: "https://frasertheking.com/crypt/images/\(imageURL!)"), placeholderImage: UIImage(named: "default"), options: []) { (image, error, cache, url) in
            self.decode()
        }
    }
    
    func decode() {
        let cipherText = cryptImageView.image?.colorString()
        let endIndex = cipherText?.index((cipherText?.endIndex)!, offsetBy: -5)
        let truncatedCipher = cipherText?.substring(to: endIndex!)
        //let identifier = cipherText?.substring(from:(cipherText?.index((cipherText?.endIndex)!, offsetBy: -5))!)
        
        do {
            let decryptedMessage = try truncatedCipher?.aesDecrypt(key: UserDefaults.standard.value(forKey: "secret_key") as! String,
                                                                         iv: UserDefaults.standard.value(forKey: "secret_iv") as! String)
            decodedMessageLabel.text = "\(decryptedMessage!)"
        } catch {
            print("Error Decrypting")
        }
    }
}
