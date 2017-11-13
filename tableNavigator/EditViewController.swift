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

    @IBOutlet weak var stretchy: UIView!
    
    var editingCard: DiscountCard? = nil
    
    var manager = CardsManager()
    
    var imageManager = FileManaging()
    
    var tappedImage: UIImageView?
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
            else{
                frontImage.image = UIImage(named:"flag.jpeg")
            }
            if (editingCard?.backImageOfCard != nil) {
                backImage.image = imageManager.getImage(nameOfImage: (editingCard?.backImageOfCard)!)
            }
            else{
                backImage.image = UIImage(named:"flag.jpeg")
            }
            if (editingCard?.barcode != nil) {
                barcodeImage.image = imageManager.getImage(nameOfImage: (editingCard?.barcode)!)
                //var tmp = editingCard?.barcode
                //barcodeNumber.text = tmp?.dropLast()
            }
            stretchy.frame =  CGRect(x: 0,y :0, width: 100, height: 100)
            
           //screenSize.height * 0.2, 50
         //   else{
         //       barcodeImage.image = UIImage(named:"flag.jpeg")
          //  }
        }
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let frontGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontImageTapped(tapGestureRecognizer:)))
        frontImage.isUserInteractionEnabled = true
        frontImage.addGestureRecognizer(frontGestureRecognizer)
        
        let backGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontImageTapped(tapGestureRecognizer:)))
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(backGestureRecognizer)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let newImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            tappedImage?.image = newImage
           
            if let pickedImageURL = info[UIImagePickerControllerImageURL] as? URL{
                let newImageName = pickedImageURL.lastPathComponent
                    if tappedImage == frontImage { frontPath = newImageName
                }
                    if tappedImage == backImage { backPath = newImageName
                }
                imageManager.saveImageDocumentDirectory(image: newImage, nameOfImage: newImageName)//"\(name)View"
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
   
    @objc func frontImageTapped (tapGestureRecognizer: UITapGestureRecognizer)
    {
        tappedImage = tapGestureRecognizer.view as? UIImageView
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        
        let alert = UIAlertController(title: "pick an image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "pictures", style: UIAlertActionStyle.default, handler: { action in
                        picker.sourceType = .savedPhotosAlbum
            picker.modalPresentationStyle = .popover
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "camera", style: UIAlertActionStyle.default, handler: { action in
            
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
            {
                picker.sourceType = UIImagePickerControllerSourceType.camera
                self.present(picker, animated: true, completion: nil)
            }
            else
            {
                let alertWarning = UIAlertController(title: "sorry", message: "camera's not available (", preferredStyle: UIAlertControllerStyle.actionSheet)
                    alertWarning.addAction(UIAlertAction(title: "got it", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alertWarning, animated: true, completion: nil)
            }
            picker.modalPresentationStyle = .popover
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "i've changed my mind", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func initCard (card: DiscountCard){   }
    
    @IBAction func barcodeNumber(_ sender: UITextField) {
        if sender.text != nil {
            barcodePath = sender.text! + ".jpeg"
        }
        barcodeImage.image = RSUnifiedCodeGenerator.shared.generateCode(sender.text!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
       
        if barcodeImage.image != nil {
            imageManager.saveImageDocumentDirectory(image: barcodeImage.image!, nameOfImage: barcodePath!)
            print("barcode")
        }
    }
    
    @IBAction func saveCard(_ sender: UIButton) {
        if editingCard != nil {
            manager.editExisting(card: editingCard!, name: name.text, descrip: decriptionCard.text, filter: filterColor, frontIMG: frontPath, backIMG: backPath, barcodeIMG: barcodePath)
        }
        else{
            if filterColor == nil { filterColor = "5"}
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
