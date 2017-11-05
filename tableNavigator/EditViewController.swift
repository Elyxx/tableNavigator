//
//  EditViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController, SendCard {

   
    @IBOutlet var childView: ChildScrollView!
    var editingCard: DiscountCard? = nil
    weak var delegate: SendCard?
    var manager = CardsManager()
    
    /*static var persistentContainer: NSPersistentContainer{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    static var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
   //
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToEdit")||(segue.identifier == "ToMainSave")||(segue.identifier == "ToMain"){
            let viewController = segue.destination as? ViewController
            viewController?.delegate = self
        }
     }*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        childView.defaultFrontImage.image = UIImage(named: "red.jpeg")
        childView.backImage.image = UIImage(named: "kitty.jpeg")
       
        childView.editingCard = editingCard
        if editingCard != nil{
            childView.newCardName.text = editingCard?.nameOfCard
            childView.descript.text = editingCard?.descriptionOfCard
        }
        else {
            childView.newCardName.text = "Type a new name"
        }
    }
    override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func initCard (card: DiscountCard){
       
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
