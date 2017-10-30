//
//  ViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FillTheTable {
    
    func refreshTable() {
        tableOfCards.reloadData()
        for item in names{
            print(item)
        }
        print("done")
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "\"The List\""
        if cardsNS.isEmpty {
            print("halepa...")
        }
        
        //tableOfCards.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseId")
   
        tableOfCards.dataSource = self //???
        tableOfCards.delegate = self
        //tableOfCards.contentSize.width = 800
        
        //tableOfCards.contentSize = CGSize(width: 1000, height: 30)
        //nea
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToEdit"){
            let editViewController = segue.destination as? EditViewController
            editViewController?.delegate = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("begin")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiscountCard")
        //var error: NSError?
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            cardsNS = fetchedResults!////
        }
        catch{
            print("Could not fetch")
        }
        print(cardsNS.count)
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
        cell.name.text = cardName.value(forKey: "nameOfCards") as? String
        cell.cardImage.image = UIImage(named:"britt.jpeg")
     /*
        let cardName = names[indexPath.row]
        cell.name.text = cardName
        cell.cardImage.image = UIImage(named:"kitten.jpeg")
 */
         return cell
    }
    
    func numberOfSections(in tableOfCards: UITableView) -> Int {      return 1   }
  

    @IBAction func newCard(_ sender: Any) {
    }
    
    @IBOutlet weak var tableOfCards: UITableView!
    
    var cardsNS: [NSManagedObject] = []
    
    internal var names: [String] =  ["Chocolate", "IceCream", "Donote"]
}

