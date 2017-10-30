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

    var manager = CardsManager()
    static var persistentContainer: NSPersistentContainer{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    static var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    weak var delegate: FillTheTable?
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultFrontImage.image = UIImage(named: "britt.jpeg")
        backImage.image = UIImage(named: "kitty.jpeg")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var newCardName: UITextField!
    
    @IBAction func saveNewData(_ sender: Any) {
        let tmpName: String! = newCardName.text!//unwrap
      
        manager.addNewCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, name: tmpName)
        //delegate?.refreshTable()
        //manager.getCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
    
    
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var defaultFrontImage: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
