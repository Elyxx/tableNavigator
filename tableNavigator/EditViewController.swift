//
//  EditViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController, sendCard {

   
    @IBOutlet var childView: ChildScrollView!
    
    
    var manager = CardsManager()
    
    var editingCard: NSManagedObjectID? = nil
    
    /*static var persistentContainer: NSPersistentContainer{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    static var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
   // weak var delegate: FillTheTable?
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "ToEdit"){
            print("edit")
             let viewController = segue.destination as? ViewController
             viewController?.delegate = self
         }
        if (segue.identifier == "ToMain"){
            print("main")
            let viewController = segue.destination as? ViewController
            viewController?.delegate = self
        }
        if (segue.identifier == "ToMainSave"){
            print("mainSave")
            let viewController = segue.destination as? ViewController
            viewController?.delegate = self
        }
     }*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     
        childView.defaultFrontImage.image = UIImage(named: "red.jpeg")
        childView.backImage.image = UIImage(named: "kitty.jpeg")
        
        //let cardName = manager.getActiveCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        /*let cardName = child.newCard?.nameOfCard
        
        if let newTitle = cardName {
            print(newTitle)
            child.newCardName.text = newTitle
        }
        else {
            child.newCardName.text = "WORK HARDER!"
        }
        */
        
        
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
    
    func initCard (cardID: NSManagedObjectID){
        //childView.newCardName.text = "THINK!"
        print("card has been initiated")
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
