//
//  FileManager.swift
//  tableNavigator
//
//  Created by adminaccount on 11/7/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import Foundation
import UIKit

class FileManaging{
    var fileManager = FileManager.default
    
    func saveImageDocumentDirectory(image: UIImage, nameOfImage: String) {
       let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(nameOfImage)
       let imageData = UIImageJPEGRepresentation(image, 1)
       fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func getImage(nameOfImage: String)->UIImage? {
        let imagePAth = (getDirectoryPath() as NSString).appendingPathComponent(nameOfImage)
        if fileManager.fileExists(atPath: imagePAth){
             return UIImage(contentsOfFile: imagePAth)
        }
        else{
            print("No Image")
            return nil
        }
    }
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
