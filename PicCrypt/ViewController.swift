//
//  ViewController.swift
//  PicCrypt
//
//  Created by Fraser King on 2016-12-10.
//  Copyright © 2016 Fraser King. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet var cryptView: CryptView?
    @IBOutlet var messageLabel: UILabel?
    @IBOutlet var inputTextView: UITextView?
    var picker : UIImagePickerController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputTextView?.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.testEncryption()
    }
    
    func testEncryption() {
        let message : String = "This is some secret text right here fraser is so dang cool omg cool dude lol i am the best the very best like no one ever was"
        var cipher : String?
        
        do {
            let temp = try message.aesEncrypt(key: "passwordpassword", iv: "drowssapdrowssap")
            cipher = temp
            self.cryptView?.text = cipher
            print(cipher!)
        } catch {
            print("Error encoding")
        }
        
        do {
            let decryptedMessage = try cipher?.aesDecrypt(key: "passwordpassword", iv: "drowssapdrowssap")
            print(decryptedMessage!)
        } catch {
            print("Error decoding")
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.cryptView?.text = textView.text
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    @IBAction func takeScreenshot(sender: UIButton) {
        self.messageLabel?.text = ""
        let image = cryptView?.takeScreenShot()
        let colorArray = image?.colorArray()
        
        var messageString : String = ""
        for color in colorArray! {
            let closeColor = CustomColors.getClosestColor(color: color)
            messageString = messageString + CharColor.colorToChar(color: closeColor)
            print(CharColor.colorToChar(color: closeColor), terminator:"")
        }
        self.messageLabel?.text = messageString
    }
    
    @IBAction func takePictureWithCamera(sender: UIButton) {
        picker = UIImagePickerController()
        picker?.delegate = self
        picker?.navigationBar.tintColor = UIColor.white
        picker?.sourceType = UIImagePickerControllerSourceType.camera
        picker?.allowsEditing = false
        picker?.cameraViewTransform = (picker?.cameraViewTransform.translatedBy(x: 0, y: 44))!;

        let overlayView: UIView = UIView(frame: CGRect(x: (self.view.frame.size.width / 2 - 125), y: (self.view.frame.size.height / 2 - 125), width: 250, height: 250))
        overlayView.layer.cornerRadius = 5
        overlayView.layer.masksToBounds = true
        overlayView.layer.borderColor = UIColor.red.cgColor
        overlayView.layer.borderWidth = 1
        
        picker?.cameraOverlayView = overlayView
        self.messageLabel?.text = ""
        self.present(picker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let scaledImage: UIImage = resizeImage(image: pickedImage, newWidth: self.view.frame.size.width)
            let rect = CGRect(x: (self.view.frame.size.width / 2 - 125), y: (self.view.frame.size.height / 2 - 210), width: 250, height: 250)
            let selectedImage : UIImage = cropImage(image: scaledImage, toRect: rect)
            
            var messageString : String = ""
            let colorArray = selectedImage.colorArray()
            for color in colorArray {
                let closeColor = CustomColors.getClosestColor(color: color)
                messageString = messageString + CharColor.colorToChar(color: closeColor)
                print(CharColor.colorToChar(color: closeColor), terminator:"")
            }
            self.messageLabel?.text = messageString
        }
        
        picker.dismiss(animated: true, completion: nil);
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

