//
//  Child.swift
//  tableNavigator
//
//  Created by adminaccount on 11/1/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import CoreData
class Child: UIView {

    var manager = CardsManager()
    var newCard: DiscountCard? = nil
    
    @IBOutlet weak var defaultFrontImage: UIImageView!
    
     @IBOutlet weak var backImage: UIImageView!
    
    
    @IBOutlet weak var newCardName: UITextField!
    @IBAction func chooseFilter(_ sender: UISegmentedControl) {
    }
    
    @IBAction func chooseColor(_ sender: UISegmentedControl) {
        /*switch  sender.selectedSegmentIndex
        {
        case 0:
            newCard?.filterByColor = 0
        case 1:
            newCard?.filterByColor = 1
        case 2:
            newCard?.filterByColor = 2
        case 3:
            newCard?.filterByColor = 3
        case 4:
            newCard?.filterByColor = 4
        default:
            break;
        }*/
    }
    @IBAction func saveCard(_ sender: UIButton) {
        let tmpName: String! = newCardName.text!//unwrap
        manager.addNewCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, name: tmpName)
    }
    /*
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
