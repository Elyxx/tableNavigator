//
//  EditViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import CoreData
import RSBarcodes_Swift
import AVFoundation

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var barcodeImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var decriptionCard: UITextView!
    @IBOutlet weak var barcodeNumber: UITextField!

    var editingCard: DiscountCard? = nil
    
    var manager = CardsManager()
    
    var imageManager = FileManaging()
    
    var filterColor: String? = nil
    var frontPath: String?
    var backPath: String?
    var barcodePath: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if editingCard != nil{
            if editingCard?.nameOfCard != nil {
                name.text = editingCard?.nameOfCard
            }
            if editingCard?.descriptionOfCard != nil {
                decriptionCard.text = editingCard?.descriptionOfCard
            }
            if (editingCard?.frontImageOfCard != nil) {
                frontImage.image = imageManager.getImage(nameOfImage: (editingCard?.frontImageOfCard)!)
            }
            if (editingCard?.backImageOfCard != nil) {
                frontImage.image = imageManager.getImage(nameOfImage: (editingCard?.frontImageOfCard)!)
            }
            if (editingCard?.barcode != nil) {
                frontImage.image = imageManager.getImage(nameOfImage: (editingCard?.frontImageOfCard)!)
            }
            else{
                frontImage.image = UIImage(named:"default.jpeg")
            }
            
        }
        else {
            //name.text = "Type a new name"
        }
        //checkPermission()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        frontImage.isUserInteractionEnabled = true
        frontImage.addGestureRecognizer(tapGestureRecognizer)
         // Do any additional setup after loading the view.
        //backImage.isUserInteractionEnabled = true
       // backImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //backImage.contentMode = .scaleAspectFit
        backImage.image = chosenImage
      
        let pickedImageURL = try? info[UIImagePickerControllerImageURL] as! URL
        let nameOfImage = pickedImageURL?.lastPathComponent
        frontPath = nameOfImage
        
        if let url = NSURL(string: (pickedImageURL?.description)!) {
            if let data = NSData(contentsOf: url as URL) {
                //let imageSize = data.length
                //print("size of image in KB: %f ", Double(imageSize) / 1024.0)
                let imageTmp = UIImage(data: data as Data)!
                imageManager.saveImageDocumentDirectory(image: imageTmp, nameOfImage: nameOfImage!)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
   
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("tapped")
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        //picker.sourceType = .savedPhotosAlbum
        //picker.sourceType = .camera
        //disablesAutomaticKeyboardDismissal = false
        picker.modalPresentationStyle = .pageSheet
        present(picker, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func initCard (card: DiscountCard){   }
    
    @IBAction func barcodeNumber(_ sender: UITextField) {
      /* 
         
         barcodeImage.image =
            RSUnifiedCodeGenerator.shared.generateCode(sender.text!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
         barcodePath = imageManager.saveImageDocumentDirectory(image: barcodeImage.image, nameOfImage: nameOfImage!)
         */
        
        print(sender.text)
    }
    
    @IBAction func saveCard(_ sender: UIButton) {
        
        
       // RSUnifiedCodeGenerator open func generateCode
        //var r: UnifiedCodeGeneratorSharedInstance
        if editingCard != nil {
            manager.editExisting(card: editingCard!, name: name.text, descrip: decriptionCard.text, filter: filterColor, frontIMG: frontPath, backIMG: backPath, barcodeIMG: barcodePath)
        }
        else{
            manager.addNewCard(name: name.text, descrip: decriptionCard.text, filter: filterColor, frontIMG: frontPath, backIMG: backPath, barcodeIMG: barcodePath)
        }
    }
    @IBAction func filter(_ sender: UISegmentedControl) {
        filterColor = String(sender.selectedSegmentIndex)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
