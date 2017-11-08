//
//  Extensions.swift
//  tableNavigator
//
//  Created by adminaccount on 11/2/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    /*public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
        let radiansToDegrees: (CGFloat) -> CGFloat = {
            return $0 * (180.0 / CGFloat(Double.pi))
        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Double.pi)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        CGContexttranslateBy(rotatedSize.width / 2.0, rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        CGContextRotateCTM(bitmap, degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        CGContextScaleCTM(bitmap, yFlip, -1.0)
        CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }*/
}

/*

 UIImageWriteToSavedPhotosAlbum(UIImage(named:"britt.jpeg")!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
 }
 @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
 if let error = error {
 // we got back an error!
 let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
 ac.addAction(UIAlertAction(title: "OK", style: .default))
 present(ac, animated: true)
 } else {
 let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
 ac.addAction(UIAlertAction(title: "OK", style: .default))
 present(ac, animated: true)
 }
 }
 
 ///////////

 let fm = FileManager.default
 let path = Bundle.main.resourcePath!
 
 do {
 let items = try fm.contentsOfDirectory(atPath: path)
 
 for item in items {
 print("Found \(item)")
 }
 } catch {
 // failed to read directory – bad permissions, perhaps?
 }
 
    
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
     func createBlock(){
 
 
       //  let imageName = "block.png"
        // let image = UIImage(named: imageName)
         let imageView = UIImageView(image: UIImage(named: "block.png"))
 
         imageView.frame = CGRect(x: xPosition, y: -50, width: size, height: size)
         self.view.addSubview(imageView)
 
         imageView.userInteractionEnabled = true
         let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageTapped"))
         imageView.addGestureRecognizer(tapRecognizer)
 
         func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
         let tappedImageView = gestureRecognizer.view!
         tappedImageView.removeFromSuperview()
     //score += 10
     }
 
 
 
     UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
 
         imageView.backgroundColor = UIColor.redColor()
         imageView.frame = CGRect(x: self.xPosition, y: 590, width: self.size, height: self.size)
 
         }, completion: { animationFinished in
 
 
         imageView.removeFromSuperview()
 
 
    })
 
 class Barcode {
 
 class func fromString(string : String) -> UIImage? {
 
 let data = string.data(using: .ascii)
 let filter = CIFilter(name: "CICode128BarcodeGenerator")
 filter?.setValue(data, forKey: "inputMessage")
 
 return UIImage(ciImage: (filter?.outputImage)!)
 }
 
 }
 
 let img = Barcode.fromString("whateva")
}*/
