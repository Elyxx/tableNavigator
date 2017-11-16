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
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    /*
     
     //UIImageWriteToSavedPhotosAlbum(UIImage(named:"chernyj_strizh.jpg")!, nil, nil, nil)
     */
    
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
/*func checkPermission() {
 let photoAuthorizationStatus =
 .authorizationStatus()
 switch photoAuthorizationStatus {
 case .authorized:
 print("Access is granted by user")
 case .notDetermined:
 PHPhotoLibrary.requestAuthorization({
 (newStatus) in
 print("status is \(newStatus)")
 if newStatus ==  PHAuthorizationStatus.authorized {
 /* do stuff here */
 print("success")
 }
 })
 print("It is not determined until now")
 case .restricted:
 // same same
 print("User do not have access to photo album.")
 case .denied:
 // same same
 print("User has denied the permission.")
 }
 }*/

/*
 func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
 {
 var alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
 var cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
 {
 UIAlertAction in
 self.openCamera()
 }
 var gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.Default)
 {
 UIAlertAction in
 self.openGallary()
 }
 var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
 {
 UIAlertAction in
 }
 
 // Add the actions
 picker?.delegate = self
 alert.addAction(cameraAction)
 alert.addAction(gallaryAction)
 alert.addAction(cancelAction)
 self.presentViewController(alert, animated: true, completion: nil)
 }
 func openCamera()
 {
 if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
 {
 picker!.sourceType = UIImagePickerControllerSourceType.Camera
 self .presentViewController(picker!, animated: true, completion: nil)
 }
 else
 {
 let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
 alertWarning.show()
 }
 }
 func openGallary()
 {
 picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
 self.presentViewController(picker!, animated: true, completion: nil)
 }
 
 //PickerView Delegate Methods
 func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
 {
 picker .dismissViewControllerAnimated(true, completion: nil)
 imageView.image=info[UIImagePickerControllerOriginalImage] as? UIImage
 }
 func imagePickerControllerDidCancel(picker: UIImagePickerController)
 {
 println("picker cancel.")
 }
 */
     //backImage.contentMode = .scaleAspectFit

//let imageSize = data.length
//print("size of image in KB: %f ", Double(imageSize) / 1024.0)

/*
 func createDirectory(){
 let fileManager = FileManager.default
 let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("customDirectory")
 if !fileManager.fileExists(atPath: paths){
 try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
 }else{
 print("Already dictionary created.")
 }
 }
 }*/
/*
 func deleteDirectory(){
 let fileManager = NSFileManager.defaultManager()
 let paths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent("customDirectory")
 if fileManager.fileExistsAtPath(paths){
 try! fileManager.removeItemAtPath(paths)
 }else{
 print("Something wronge.")
 }
 }*/
////////
/*   func enumerateDirectory() -> String? {
 //var error: NSError?
 let filesInDirectory = try? fileManager.contentsOfDirectory(atPath: tmpDir)
 
 if let files = filesInDirectory {
 if files.count > 0 {
 if files[0] == fileName {
 print("sample.txt found")
 return files[0]
 } else {
 print("File not found")
 return nil
 }
 }
 }
 return nil
 }
 func createFile() {
 let path = (tmpDir as NSString).appendingPathComponent(fileName)
 let contentsOfFile = "Sample Text"
 //var error: NSError?
 
 // Write File
 do{
 try contentsOfFile.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
 //if let errorMessage = error {
 //    print("Failed to create file")
 //    print("\(errorMessage)")
 //}
 }
 catch {
 print("Failed to create file")
 }
 }
 func listDirectory() {
 // List Content of Path
 let isFileInDir = enumerateDirectory() ?? "Empty"
 print("Contents of Directory =  \(isFileInDir)")
 }
 
 func viewFileContent() {
 let isFileInDir = enumerateDirectory() ?? ""
 
 let path = (tmpDir as NSString).appendingPathComponent(isFileInDir)
 let contentsOfFile = try? NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
 
 if let content = contentsOfFile {
 print("Content of file = \(content)")
 } else {
 print("No file found")
 }
 }
 
 func deleteFile() {
 //var error: NSError?
 
 if let isFileInDir = enumerateDirectory() {
 let path = (tmpDir as NSString).appendingPathComponent(isFileInDir)
 try? fileManager.removeItem(atPath: path)
 } else {
 print("No file found")
 }
 }
 }*/

