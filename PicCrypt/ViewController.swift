//
//  ViewController.swift
//  PicCrypt
//
//  Created by Fraser King on 2016-12-10.
//  Copyright © 2016 Fraser King. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var cryptView: CryptView?
    let image = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        image.delegate = self
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
    
    @IBAction func takePictureWithCamera(sender: UIButton) {
        image.navigationBar.tintColor = UIColor.white
        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        image.cameraViewTransform = image.cameraViewTransform.translatedBy(x: 0, y: 44);

        let overlayView: UIView = UIView(frame: CGRect(x: (self.view.frame.size.width / 2 - 125), y: (self.view.frame.size.height / 2 - 125), width: 250, height: 250))
        overlayView.layer.cornerRadius = 5
        overlayView.layer.masksToBounds = true
        overlayView.layer.borderColor = UIColor.red.cgColor
        overlayView.layer.borderWidth = 1
        
        image.cameraOverlayView = overlayView
        self.present(image, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let scaledImage: UIImage = resizeImage(image: pickedImage, newWidth: self.view.frame.size.width)
            let rect = CGRect(x: (self.view.frame.size.width / 2 - 125), y: (self.view.frame.size.height / 2 - 210), width: 250, height: 250)
            let selectedImage : UIImage = cropImage(image: scaledImage, toRect: rect)
            let imageView = UIImageView(image: selectedImage)
            imageView.frame = CGRect(x: 50, y: 400, width: 250, height: 250)
            self.view.addSubview(imageView)
            
            let colorArray = selectedImage.colorArray()
            for color in colorArray {
                let closeColor = CustomColors.getClosestColor(color: color)
               // print(CustomColors.getHexString(color: color))
                print(CharColor.colorToChar(color: closeColor), terminator:"")
            }
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

