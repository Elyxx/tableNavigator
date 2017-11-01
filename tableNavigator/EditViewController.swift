//
//  EditViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet var child: Child!
    
    var manager = CardsManager()
    var newCard: DiscountCard? = nil
    
    /*static var persistentContainer: NSPersistentContainer{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    static var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }*/
   // weak var delegate: FillTheTable?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        child.defaultFrontImage.image = UIImage(named: "red.jpeg")
        child.backImage.image = UIImage(named: "kitty.jpeg")
        
        let cardName = manager.getActiveCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        
        if let newTitle = cardName?.value(forKey: "nameOfCard") as? String {
            print(newTitle)
            child.newCardName.text = newTitle
        }
        else {
            child.newCardName.text = "WORK HARDER!"
        }
        
        
        
        /*if let url = NSURL(string: "http://www.petsfriend.ca/media/k2/items/cache/95afb94bcb9e5971a68576edb0850e71_S.jpg") {
         if let myData = NSData(contentsOf: url as URL) {
         backImage.image = UIImage(data: myData as Data)
         }
         }*/
        
        
    }
    override func viewDidLoad() {
         super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
   
    @IBAction func chooseFilter(_ sender: UISegmentedControl) {
        
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
