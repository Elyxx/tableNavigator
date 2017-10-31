//
//  ViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var manager = CardsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if cardsNS.isEmpty {            print("halepa...")        }
        
        tableOfCards.dataSource = self //???
        tableOfCards.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToEdit"){
            let editViewController = segue.destination as? EditViewController
            editViewController?.delegate = self
        }
    }*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("begin")
        cardsNS = manager.getCards(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)!
        tableOfCards.reloadData()
        
       /* let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiscountCard")
        //var error: NSError?
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            //cardsNS = fetchedResults!////
        }
        catch{
            print("Could not fetch")
        }
        //var nmv = DiscountCard()
        
        print(cardsNS.count)*/
        print("end")
    }
    
    func tableView(_ tableOfCards: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return names.count
        return cardsNS.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            print("edit")
            self.performSegue(withIdentifier: "ToEdit", sender: self)
        }
        let lightViolet = UIColor(red: 229.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        editAction.backgroundColor = lightViolet
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
        }
        shareAction.backgroundColor = .green
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            let predicat = self.cardsNS[indexPath.row].value(forKey: "nameOfCard") as? String
            //unwrap
            self.manager.deleteCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, stringPredicat: predicat!)
        }
        deleteAction.backgroundColor = .red
        
        return [editAction, shareAction, deleteAction]
    }
    
    func tableView(_ tableOfCards: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableOfCards.dequeueReusableCell(withIdentifier: "cellReuseId") as! CardTableViewCell
     
        let cardName = cardsNS[indexPath.row]
        cell.name.text = cardName.value(forKey: "nameOfCard") as? String
        //print("cell text \(String(describing: cell.name.text))")
        
        cell.cardImage.image = UIImage(named:"britt.jpeg")
        
        return cell
    }
    
    func numberOfSections(in tableOfCards: UITableView) -> Int {      return 1   }
  

    
    
    @IBOutlet weak var tableOfCards: UITableView!
    
    var cardsNS: [NSManagedObject] = []
    
    internal var names: [String] =  ["Chocolate", "IceCream", "Donote"]
}

