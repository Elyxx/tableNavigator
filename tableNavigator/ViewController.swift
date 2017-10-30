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
        cardsNS = manager.getCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)!
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
    /*
    func tableView(_ tableOfCards: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        let alertController = UIAlertController(title: "Hint", message: "You have selected row \(indexPath.row).", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)*/
        
    }
    */
    func tableView(_ tableOfCards: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableOfCards.dequeueReusableCell(withIdentifier: "cellReuseId") as! CardTableViewCell
     
        let cardName = cardsNS[indexPath.row]
        cell.name.text = cardName.value(forKey: "nameOfCard") as? String
        print("cell text \(String(describing: cell.name.text))")
        cell.cardImage.image = UIImage(named:"britt.jpeg")
     /*
        let cardName = names[indexPath.row]
        cell.name.text = cardName
        cell.cardImage.image = UIImage(named:"kitten.jpeg")
 */
         return cell
    }
    
    func numberOfSections(in tableOfCards: UITableView) -> Int {      return 1   }
  

    
    
    @IBOutlet weak var tableOfCards: UITableView!
    
    var cardsNS: [NSManagedObject] = []
    
    internal var names: [String] =  ["Chocolate", "IceCream", "Donote"]
}

