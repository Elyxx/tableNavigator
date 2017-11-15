//
//  StretchViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 11/15/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit

class StretchViewController: UIViewController, UIScrollViewDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let logo = UIImage(named: "flag.jpeg")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        navigationItem.titleView?.sizeToFit()
        
        let frontGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontImageTapped(tapGestureRecognizer:)))
        frontImage.isUserInteractionEnabled = true
        frontImage.addGestureRecognizer(frontGestureRecognizer)
        
        let backGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontImageTapped(tapGestureRecognizer:)))
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(backGestureRecognizer)
        
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
        name.backgroundColor = .cGreen
        name.layer.cornerRadius = name.frame.width/20.0
        name.clipsToBounds = true
        scroll.addSubview(name)
        totalHeight += additionalHeight
        totalHeight += margin
        
        //2//front
        additionalHeight = (currentWidth - margin*2)*0.63
        scroll.addSubview(createImageView(currentZero: CGPoint(x: margin ,y: totalHeight), height: additionalHeight, currentImage: UIImage(named: "empty.png")!))
        totalHeight += additionalHeight
        totalHeight += margin
        
        //3//back
        additionalHeight = (currentWidth - margin*2)*0.63
        scroll.addSubview(createImageView(currentZero: CGPoint(x: margin ,y: totalHeight), height: additionalHeight, currentImage: UIImage(named: "empty.png")!))
        totalHeight += additionalHeight
        totalHeight += margin
        
        //4//barcodeImage
        additionalHeight = (currentWidth - margin*2)*0.3
        scroll.addSubview(createImageView(currentZero: CGPoint(x: margin ,y: totalHeight), height: additionalHeight, currentImage: UIImage(named: "Barcode2.png")!))
        totalHeight += additionalHeight
        totalHeight += margin
        
        //5//number
        additionalHeight = 30
        barcodeNumber = UITextField(frame: CGRect(x: margin, y: totalHeight, width: currentWidth - margin*2, height: additionalHeight))
        barcodeNumber.backgroundColor = .cPink
        barcodeNumber.layer.cornerRadius = barcodeNumber.frame.width/20.0
        barcodeNumber.clipsToBounds = true
        scroll.addSubview(barcodeNumber)
        totalHeight += additionalHeight
        totalHeight += margin
        
        //6//descriptionCard
        additionalHeight = 60
        decriptionCard = UITextView(frame: CGRect(x: margin, y: totalHeight, width: currentWidth - margin*2, height: additionalHeight))
        decriptionCard.backgroundColor = .cLightViolet
        decriptionCard.isScrollEnabled = false
/*CGSize sizeThatFitsTextView = [TextView sizeThatFits:CGSizeMake(TextView.frame.size.width, MAXFLOAT)];
 
 TextViewHeightConstraint.constant = sizeThatFitsTextView.height;
 */
        
        decriptionCard.layer.cornerRadius = decriptionCard.frame.width/20.0
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
        coloredFilter.tintColor = .cNotWhite
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
        buttonSave.layer.cornerRadius = buttonSave.frame.width/20.0
        buttonSave.clipsToBounds = true
        scroll.addSubview(buttonSave)
        totalHeight += additionalHeight
        totalHeight += margin
        //resize scroll
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: totalHeight)
        
        loadData()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        <#code#>
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
        picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
        imageView.backgroundColor = .cYellow
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
            manager.addNewCard(name: name.text, descrip: decriptionCard.text, filter: filterColor, frontIMG: frontPath, backIMG: backPath, barcodeIMG: barcodePath)
        }
        print("Button tapped")
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
        }
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
