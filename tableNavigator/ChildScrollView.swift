//
//  ChildScrollView.swift
//  tableNavigator
//
//  Created by adminaccount on 11/2/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

  import UIKit
  import CoreData

  class ChildScrollView: UIView {
        
        var filter: String? = nil
        var manager = CardsManager()
        var editingCard: NSManagedObjectID? = nil
        
   
    @IBOutlet weak var defaultFrontImage: UIImageView!

    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var newCardName: UITextField!
    
    @IBOutlet weak var descript: UITextView!
    
    @IBAction func chooseColor(_ sender: UISegmentedControl) {
         filter = String(sender.selectedSegmentIndex)
         print(descript.text)
    }
   
    @IBAction func saveCard(_ sender: UIButton) {
    manager.addNewCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, name: newCardName.text, descrip: descript.text, filter: filter)
    
        }
        /*
         // Only override draw() if you perform custom drawing.
         // An empty implementation adversely affects performance during animation.
         override func draw(_ rect: CGRect) {
         // Drawing code
         }
         */
        
}

