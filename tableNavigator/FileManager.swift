//
//  FileManager.swift
//  tableNavigator
//
//  Created by adminaccount on 11/7/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import Foundation

class fileManaging{
    var fileManager = FileManager()
    var tmpDir = NSTemporaryDirectory()
    let fileName = "sample.txt"
    
    func enumerateDirectory() -> String? {
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
}
