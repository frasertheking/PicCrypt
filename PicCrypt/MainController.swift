//
//  MainController.swift
//  PicCrypt
//
//  Created by Fraser King on 2016-12-10.
//  Copyright © 2016 Fraser King. All rights reserved.
//

import UIKit
import ISHPullUp

class MainController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, ISHPullUpContentDelegate {
    
    @IBOutlet private weak var rootView: UIView!
    @IBOutlet var cryptView: CryptView?
    @IBOutlet var messageLabel: UILabel?
    @IBOutlet var inputTextView: UITextView?
    var picker : UIImagePickerController?
    var cipher : String?
    var key : String?
    var iv : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        key = String.randomString(length: 32)
        iv = String.randomString(length: 16)
        
        do {
            let temp = try inputTextView?.text.aesEncrypt(key: key!, iv: iv!)
            cipher = temp
            self.cryptView?.text = cipher
        } catch {
            self.messageLabel?.text = "Error Encrypting"
        }
        
        self.inputTextView?.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.setupParallax()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        do {
            let temp = try textView.text.aesEncrypt(key: key!, iv: iv!)
            cipher = temp
            self.cryptView?.text = cipher
        } catch {
            self.messageLabel?.text = "Error Encrypting"
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    @IBAction func decode(sender: UIButton) {
        self.messageLabel?.text = ""
        let image = cryptView?.takeScreenShot()
        let cipherText = image?.colorString()
        let endIndex = cipherText?.index((cipherText?.endIndex)!, offsetBy: -5)
        let truncatedCipher = cipherText?.substring(to: endIndex!)
        let identifier = cipherText?.substring(from:(cipherText?.index((cipherText?.endIndex)!, offsetBy: -5))!)
        self.messageLabel?.text = truncatedCipher

        print("\(identifier!)")
        do {
            let decryptedMessage = try truncatedCipher?.aesDecrypt(key: key!, iv: iv!)
            self.messageLabel?.text = decryptedMessage
        } catch {
            self.messageLabel?.text = "Error Decrypting"
        }
    }
    
    @IBAction func takePictureWithCamera(sender: UIButton) {
//        picker = UIImagePickerController()
//        picker?.delegate = self
//        picker?.navigationBar.tintColor = UIColor.white
//        picker?.sourceType = UIImagePickerControllerSourceType.camera
//        picker?.allowsEditing = false
//        picker?.cameraViewTransform = (picker?.cameraViewTransform.translatedBy(x: 0, y: 44))!;
//
//        let overlayView: UIView = UIView(frame: CGRect(x: (self.view.frame.size.width / 2 - 125), y: (self.view.frame.size.height / 2 - 125), width: 250, height: 250))
//        overlayView.layer.cornerRadius = 5
//        overlayView.layer.masksToBounds = true
//        overlayView.layer.borderColor = UIColor.red.cgColor
//        overlayView.layer.borderWidth = 1
//        
//        picker?.cameraOverlayView = overlayView
//        self.messageLabel?.text = ""
//        self.present(picker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            let scaledImage: UIImage = resizeImage(image: pickedImage, newWidth: self.view.frame.size.width)
//            let rect = CGRect(x: (self.view.frame.size.width / 2 - 125), y: (self.view.frame.size.height / 2 - 210), width: 250, height: 250)
////            let selectedImage : UIImage = cropImage(image: scaledImage, toRect: rect)
//            
////            var messageString : String = ""
//        //    let colorArray = selectedImage.colorArray()
//        //    for color in colorArray {
//               // let closeColor = CustomColors.getClosestColor(color: color)
//               // messageString = messageString + CharColor.colorToChar(color: closeColor)
//               // print(CharColor.colorToChar(color: closeColor), terminator:"")
//          //  }
//           // self.messageLabel?.text = messageString
//        }
//        
//        picker.dismiss(animated: true, completion: nil);
    }
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func setupParallax() {
        // Set vertical effect
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                                                               type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -10
        verticalMotionEffect.maximumRelativeValue = 10
        
        // Set horizontal effect
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                                                                 type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -10
        horizontalMotionEffect.maximumRelativeValue = 10
        
        // Create group to combine both
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        // Add both effects to your view
        cryptView?.addMotionEffect(group)
    }
    
    func pullUpViewController(_ vc: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forContentViewController _: UIViewController) {
        // update edgeInsets
        rootView.layoutMargins = edgeInsets
        
        // call layoutIfNeeded right away to participate in animations
        // this method may be called from within animation blocks
        rootView.layoutIfNeeded()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

