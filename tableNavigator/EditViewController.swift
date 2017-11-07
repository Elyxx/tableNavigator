//
//  EditViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController, SendCard, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   
    var editingCard: DiscountCard? = nil
    weak var delegate: SendCard?
    var manager = CardsManager()
    
    
    
    
    
    var filterColor: String? = nil
    
    @IBOutlet weak var frontImage: UIImageView!
  
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var barcodeImage: UIImageView!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var decriptionCard: UITextView!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToEdit"){
            let viewController = segue.destination as? ViewController
            viewController?.delegate = self
            print("save")
        }
        if (segue.identifier == "ToMain"){
            let viewController = segue.destination as? ViewController
            viewController?.delegate = self
            print("back")
        }
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        frontImage.image = UIImage(named: "chernyj_strizh.jpg")
        //backImage.image = UIImage(named: "kitty.jpeg")
       
        if editingCard != nil{
            name.text = editingCard?.nameOfCard
            decriptionCard.text = editingCard?.descriptionOfCard
        }
        else {
            name.text = "Type a new name"
        }
        //checkPermission()
    }
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
    override func viewDidLoad() {
         super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        frontImage.isUserInteractionEnabled = true
        frontImage.addGestureRecognizer(tapGestureRecognizer)
         // Do any additional setup after loading the view.

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        backImage.contentMode = .scaleAspectFit
        backImage.image = chosenImage
 
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
  
    }
   
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
       // let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("tapped")
        frontImage.image = UIImage(named: "red.jpeg")
        // Your action
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        //picker.sourceType = .savedPhotosAlbum
        //picker.sourceType = .camera
        //disablesAutomaticKeyboardDismissal = false
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        //picker.popoverPresentationController?.barButtonItem = self

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func initCard (card: DiscountCard){   }
    
    @IBAction func saveCard(_ sender: UIButton) {
        if editingCard != nil {
            manager.editExisting(card: editingCard!, name: name.text, descrip: decriptionCard.text, filter: filterColor)
        }
        else{
            manager.addNewCard(name: name.text, descrip: decriptionCard.text, filter: filterColor)
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
