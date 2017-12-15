//
//  EditViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 12/14/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import RSBarcodes_Swift
import AVFoundation

class EditViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {

    var editingCard: DiscountCard? = nil
    var manager = CardsManager()
    var imageManager = FileManaging()
    
    let segueToMain = "ToMain"
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var barcodeImage: UIImageView!
    @IBOutlet weak var barcodeNumber: UITextField!
    @IBOutlet weak var decriptionCard: UITextView!
    @IBOutlet weak var coloredFilter: UISegmentedControl!
    @IBOutlet weak var buttonSave: UIButton!
    
    var tappedImage: UIImageView?
    var filterColor: Int32?
    var frontPath: String?
    var backPath: String?
    var barcodePath: String?
    var previewPath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        barcodeNumber.delegate = self
        decriptionCard.delegate = self
        
        coloredFilter.subviews[4].backgroundColor = UIColor.cYellow
        coloredFilter.subviews[3].backgroundColor = UIColor.cGray
        coloredFilter.subviews[2].backgroundColor = UIColor.cGreen
        coloredFilter.subviews[1].backgroundColor = UIColor.cPink
        coloredFilter.subviews[0].backgroundColor = UIColor.cViolet
        
        buttonSave.layer.cornerRadius = buttonSave.frame.width/50.0
   
        loadData()
        
        let frontGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontImageTapped(tapGestureRecognizer:)))
        frontImage.isUserInteractionEnabled = true
        frontImage.addGestureRecognizer(frontGestureRecognizer)
        
        let backGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontImageTapped(tapGestureRecognizer:)))
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(backGestureRecognizer)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        frontImage.layer.cornerRadius = frontImage.frame.width/16.0
        backImage.layer.cornerRadius = frontImage.frame.width/16.0
        navigationItem.titleView = UIImageView(image: .logo)
        navigationItem.titleView?.sizeToFit()
        navigationItem.titleView?.isOpaque = true
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
    }
 
    func textViewDidEndEditing(_ textView: UITextView) {
        //if textField != name {
            UIView.animate(withDuration: 0.25, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y:self.view.frame.origin.y + 210, width: self.view.frame.size.width, height: self.view.frame.size.height)
            })
        //}
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //if textField != name {
            UIView.animate(withDuration: 0.25, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y:self.view.frame.origin.y - 170, width: self.view.frame.size.width, height: self.view.frame.size.height)
            })
        //}
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField != name {
             UIView.animate(withDuration: 0.25, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y:self.view.frame.origin.y + 170, width: self.view.frame.size.width, height: self.view.frame.size.height)
            })
        }
        if barcodeNumber.text != nil{
            print("barcode")
            if let tmpBarcode = RSUnifiedCodeGenerator.shared.generateCode(barcodeNumber.text!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue) {
                barcodePath = barcodeNumber.text! + ".jpeg"
                barcodeImage.image = tmpBarcode
                print("image")
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField != name {
               UIView.animate(withDuration: 0.25, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y:self.view.frame.origin.y - 210, width: self.view.frame.size.width, height: self.view.frame.size.height)
            })
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let newImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            tappedImage?.image = newImage
            
            if let pickedImageURL = info[UIImagePickerControllerImageURL] as? URL{
                let newImageName = pickedImageURL.lastPathComponent
                if tappedImage == frontImage {
                    frontPath = newImageName
                }
                if tappedImage == backImage {
                    backPath = newImageName
                }
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
    
    
    @IBAction func backToMain(_ sender: UIBarButtonItem) {
         performSegue(withIdentifier: segueToMain, sender: self)
    }
    
    func loadData(){
        if editingCard != nil{
            if editingCard?.nameOfCard != nil {
                name.text = editingCard?.nameOfCard
            }
            if editingCard?.descriptionOfCard != nil {
                decriptionCard.text = editingCard?.descriptionOfCard
                //textViewDidChange(decriptionCard)
            }
            if (editingCard?.frontImageOfCard != nil) {
                frontImage.image = imageManager.getImage(nameOfImage: (editingCard?.frontImageOfCard)!)
            }
       //     else{
       //         frontImage.image = UIImage.defaultImage
       //     }
            if (editingCard?.backImageOfCard != nil) {
                backImage.image = imageManager.getImage(nameOfImage: (editingCard?.backImageOfCard)!)
            }
       //     else{
       //         backImage.image = UIImage.defaultImage
       //     }
            if (editingCard?.barcode != nil) {
                barcodeImage.image = imageManager.getImage(nameOfImage: (editingCard?.barcode)!)
            }
            else{
                barcodeImage.image = UIImage.barcode
            }
        }
    }
    
    @IBAction func saveInfo(_ sender: UIButton) {
        if frontPath != nil{
            imageManager.saveImageDocumentDirectory(image: frontImage.image!, nameOfImage: frontPath!)
            previewPath = "p" + frontPath!
            if previewPath != nil{
                if let previewImage = frontImage.image?.resizeImage(newWidth: 256){
                    imageManager.saveImageDocumentDirectory(image: previewImage, nameOfImage: previewPath!)
                }
            }
        }
        
        if backPath != nil{
            imageManager.saveImageDocumentDirectory(image: backImage.image!, nameOfImage: backPath!)
        }
        
        if barcodePath != nil{
            imageManager.saveImageDocumentDirectory(image: barcodeImage.image!, nameOfImage: barcodePath!)
        }
        
        filterColor = Int32(coloredFilter.selectedSegmentIndex)
        
        if editingCard != nil {
            manager.editExisting(card: editingCard!, name: name.text, descrip: decriptionCard.text, filter: filterColor, previewIMG: previewPath, frontIMG: frontPath, backIMG: backPath, barcodeIMG: barcodePath)
        }
            
        else{
            if name.text == nil && decriptionCard.text == nil && filterColor == nil && frontPath == nil && backPath == nil && barcodePath == nil {
                let alert = UIAlertController(title: "all fields are empty", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
                alert.addAction(UIAlertAction(title: "i know", style: UIAlertActionStyle.cancel, handler: /*{ action in self.userCaution = true }*/ nil ))
                self.present(alert, animated: true, completion: nil)
            }
            manager.addNewCard(name: name.text, descrip: decriptionCard.text, filter: filterColor, previewIMG: previewPath, frontIMG: frontPath, backIMG: backPath, barcodeIMG: barcodePath)
        }
        performSegue(withIdentifier: segueToMain , sender: self)
    }
}
