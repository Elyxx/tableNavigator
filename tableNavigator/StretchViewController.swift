//
//  StretchViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 11/15/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import RSBarcodes_Swift
import AVFoundation

class StretchViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    let segueToMain = "ToMain"
    var scroll : UIScrollView!
    var container : UIView!
    
    var name: UITextField!
    var frontImage: UIImageView!
    var backImage: UIImageView!
    var barcodeImage: UIImageView!
    var barcodeNumber: UITextField!
    var decriptionCard: UITextView!
    var coloredFilter: UISegmentedControl!
    var buttonSave: UIButton!
    
    var editingCard: DiscountCard? = nil
    
    var manager = CardsManager()
    
    var imageManager = FileManaging()
    
    var tappedImage: UIImageView?
    var filterColor: String?
    var frontPath: String?
    var backPath: String?
    var barcodePath: String?
    
    let margin: CGFloat = 10
    var totalHeight: CGFloat = 0
    
    let currentWidth = UIScreen.main.bounds.width
    let currentHeight = UIScreen.main.bounds.height
    
    var userCaution = false

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = UIImageView(image: .logo)
        navigationItem.titleView?.sizeToFit()
        navigationItem.titleView?.isOpaque = true
   }


   override func viewDidLoad() {
        super.viewDidLoad()
    
        var additionalHeight: CGFloat = 0
        totalHeight += additionalHeight
        totalHeight += margin
    
        scroll = UIScrollView(frame: view.bounds)
        scroll.delegate = self
        scroll.isScrollEnabled = true
        view.addSubview(scroll)
    
        container = UIView()
        scroll.addSubview(container)
        scroll.backgroundColor = UIColor.cViolet
        //scroll.backgroundColor = UIColor(patternImage: UIImage(named: "GrayLeather.jpg")!)
    
        //1//name
        additionalHeight = 30.00
        name = UITextField(frame: CGRect(x: margin, y: margin, width: currentWidth - margin*2, height: additionalHeight))
        name.backgroundColor = .cNotWhite
        name.layer.cornerRadius = name.frame.width/50.0
        name.clipsToBounds = true
        scroll.addSubview(name)
        totalHeight += additionalHeight
        totalHeight += margin
    
        //2//front
        additionalHeight = (currentWidth - margin*2)*0.63
        frontImage = createImageView(currentZero: CGPoint(x: margin ,y: totalHeight), height: additionalHeight, currentImage: UIImage(named: "empty.png")!)
        frontImage.isUserInteractionEnabled = true
        scroll.addSubview(frontImage)
        totalHeight += additionalHeight
        totalHeight += margin
    
        //3//back
        additionalHeight = (currentWidth - margin*2)*0.63
        backImage = createImageView(currentZero: CGPoint(x: margin ,y: totalHeight), height: additionalHeight, currentImage: UIImage(named: "empty.png")!)
        backImage.isUserInteractionEnabled = true
        scroll.addSubview(backImage)
        totalHeight += additionalHeight
        totalHeight += margin
    
        //4//barcodeImage
        additionalHeight = (currentWidth - margin*2)*0.3
        barcodeImage = createImageView(currentZero: CGPoint(x: margin ,y: totalHeight), height: additionalHeight, currentImage: UIImage(named: "Barcode2.png")!)
        scroll.addSubview(barcodeImage)
        totalHeight += additionalHeight
        totalHeight += margin
    
        //5//number
        additionalHeight = 30
        barcodeNumber = UITextField(frame: CGRect(x: margin, y: totalHeight, width: currentWidth - margin*2, height: additionalHeight))
        barcodeNumber.backgroundColor = .cPink
        barcodeNumber.isUserInteractionEnabled = true
        barcodeNumber.delegate = self
       // barcodeNumber.layer.cornerRadius = barcodeNumber.frame.width/13.0
       // barcodeNumber.clipsToBounds = true
        scroll.addSubview(barcodeNumber)
        totalHeight += additionalHeight
        totalHeight += margin
    
        //6//descriptionCard
        additionalHeight = 60
        decriptionCard = UITextView(frame: CGRect(x: margin, y: totalHeight, width: currentWidth - margin*2, height: additionalHeight))
        decriptionCard.backgroundColor = .cNotWhite
        decriptionCard.isScrollEnabled = false
        decriptionCard.isUserInteractionEnabled = true
        //decriptionCard.sizeToFit()
        decriptionCard.delegate = self
    
    /*
 textView.font = UIFont.systemFont(ofSize: 20)
 textView.textColor = UIColor.white
 
 textView.font = UIFont.boldSystemFont(ofSize: 20)
 textView.font = UIFont(name: "Verdana", size: 17)*/
    
        /*CGSize sizeThatFitsTextView = [TextView sizeThatFits:CGSizeMake(TextView.frame.size.width, MAXFLOAT)];
     
         TextViewHeightConstraint.constant = sizeThatFitsTextView.height;
         */
    
        decriptionCard.layer.cornerRadius = decriptionCard.frame.width/40.0
        decriptionCard.clipsToBounds = true
        scroll.addSubview(decriptionCard)
        totalHeight += additionalHeight
        totalHeight += margin
    
        //filter
        additionalHeight = 30
        let items = ["food", "market", "cinema", "beauty", "other"]
        coloredFilter = UISegmentedControl(items: items)
        //coloredFilter.backgroundColor = .white
        //coloredFilter.addTarget(self, action: "changeColor:", for: .ValueChanged)
        //func changeColor(sender: UISegmentedControl)
        coloredFilter.frame = CGRect(x: margin, y: totalHeight, width: currentWidth - margin*2, height: additionalHeight)
        coloredFilter.backgroundColor = .black
        coloredFilter.tintColor = UIColor(red: 139.0/255.0, green: 155.0/255.0, blue: 129.0/255.0, alpha: 1.0)
        coloredFilter.selectedSegmentIndex = 0
        coloredFilter.subviews[0].backgroundColor = UIColor.cYellow
        coloredFilter.subviews[1].backgroundColor = UIColor.cGray
        coloredFilter.subviews[2].backgroundColor = UIColor.cGreen
        coloredFilter.subviews[3].backgroundColor = UIColor.cPink
        coloredFilter.subviews[4].backgroundColor = UIColor.cViolet
        scroll.addSubview(coloredFilter)
        totalHeight += additionalHeight
        totalHeight += margin
    
        //button
        additionalHeight = 60
        buttonSave = UIButton(frame: CGRect(x: margin, y: totalHeight, width: currentWidth - margin*2, height: additionalHeight))
        buttonSave.backgroundColor = .cLightViolet
        buttonSave.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        buttonSave.setTitle("SAVE", for: .normal)
        buttonSave.setTitleColor(.black, for: .normal)
        buttonSave.layer.cornerRadius = buttonSave.frame.width/50.0
        buttonSave.clipsToBounds = true
        scroll.addSubview(buttonSave)
        totalHeight += additionalHeight
        totalHeight += margin
        //resize scroll
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: totalHeight)
    
        loadData()
        
        let frontGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontImageTapped(tapGestureRecognizer:)))
        frontImage.isUserInteractionEnabled = true
        frontImage.addGestureRecognizer(frontGestureRecognizer)
        
        let backGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontImageTapped(tapGestureRecognizer:)))
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(backGestureRecognizer)
        // Do any additional setup after loading the view.
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
    
    func createImageView(currentZero: CGPoint, height: CGFloat, currentImage: UIImage) -> UIImageView{
        let imageView = UIImageView(image: currentImage)
        let newWidth = UIScreen.main.bounds.width - 20
        //let newHeight = newWidth*0.63
        imageView.frame = CGRect(x: currentZero.x, y: currentZero.y , width: newWidth, height: height)
        //imageView.backgroundColor = .cYellow
        imageView.layer.cornerRadius = imageView.frame.width/16.0
        imageView.clipsToBounds = true
        return imageView
    }
   
    @objc func buttonAction(sender: UIButton!) {
        filterColor = String(coloredFilter.selectedSegmentIndex)
        if editingCard != nil {
            manager.editExisting(card: editingCard!, name: name.text, descrip: decriptionCard.text, filter: filterColor, frontIMG: frontPath, backIMG: backPath, barcodeIMG: barcodePath)
        }
        else{
            if filterColor == nil { filterColor = "0"}
            if name.text == nil && decriptionCard.text == nil && filterColor == nil && frontPath == nil && backPath == nil && barcodePath == nil && userCaution == false {
                let alert = UIAlertController(title: "all fields are empty", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
                alert.addAction(UIAlertAction(title: "i know", style: UIAlertActionStyle.cancel, handler: { action in self.userCaution = true } ))
                self.present(alert, animated: true, completion: nil)
            }
            manager.addNewCard(name: name.text, descrip: decriptionCard.text, filter: filterColor, frontIMG: frontPath, backIMG: backPath, barcodeIMG: barcodePath)
        }
        performSegue(withIdentifier: segueToMain , sender: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if barcodeNumber.text != nil {
            barcodePath = barcodeNumber.text! + ".jpeg"
        }
        barcodeImage.image = RSUnifiedCodeGenerator.shared.generateCode(barcodeNumber.text!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
        
        if barcodeImage.image != nil {
            imageManager.saveImageDocumentDirectory(image: barcodeImage.image!, nameOfImage: barcodePath!)
        }
        print("barcode")
    }
    func textViewDidChange(_ textView: UITextView) {
        print("oops")
    }
    
    func loadData(){
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
                frontImage.image = UIImage.defaultImage
            }
            if (editingCard?.backImageOfCard != nil) {
                backImage.image = imageManager.getImage(nameOfImage: (editingCard?.backImageOfCard)!)
            }
            else{
                backImage.image = UIImage.defaultImage
            }
            if (editingCard?.barcode != nil) {
                barcodeImage.image = imageManager.getImage(nameOfImage: (editingCard?.barcode)!)
                //var tmp = editingCard?.barcode
                //barcodeNumber.text = tmp?.dropLast()
            }
        }
    }
    
    @IBAction func bakToMain(_ sender: UIBarButtonItem) {
             performSegue(withIdentifier: segueToMain, sender: self)
        
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
