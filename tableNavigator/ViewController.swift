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
    var myCards = [DiscountCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if cardsNS.isEmpty {            print("halepa...")        }
        
        tableOfCards.dataSource = self //???
        tableOfCards.delegate = self
        
        let lightRed = UIColor(red: 255.0/255.0, green: 236.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        let lightGreen = UIColor(red: 239.0/255.0, green: 255.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        var subViewOfSegment: UIView = coloredFilter.subviews[1] as UIView
        subViewOfSegment.backgroundColor = lightGreen
        subViewOfSegment = coloredFilter.subviews[3] as UIView
        subViewOfSegment.backgroundColor = lightRed
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
        myCards = manager.getCards(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)!
        //unwrap
        tableOfCards.reloadData()
    }
    
    func tableView(_ tableOfCards: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myCards.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "edit") { (rowAction, indexPath) in
            let predicat = self.myCards[indexPath.row].nameOfCard
            self.manager.setActiveCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, stringPredicat: predicat!)
            self.performSegue(withIdentifier: "ToEdit", sender: self)
        }
        let lightViolet = UIColor(red: 229.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        editAction.backgroundColor = lightViolet
        
        let shareAction = UITableViewRowAction(style: .normal, title: "share") { (rowAction, indexPath) in
            //print(myCards.nameOfCard)
        }
        let lightGreen = UIColor(red: 239.0/255.0, green: 255.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        shareAction.backgroundColor = lightGreen
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "delete") { (rowAction, indexPath) in
            let predicat = self.myCards[indexPath.row].nameOfCard
            //unwrap
            self.manager.deleteCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, stringPredicat: predicat!)
            //if more then one crash accured
            self.tableOfCards.reloadData()
        }
        let lightRed = UIColor(red: 255.0/255.0, green: 236.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = lightRed
        
        return [editAction, shareAction, deleteAction]
    }
    
    func tableView(_ tableOfCards: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableOfCards.dequeueReusableCell(withIdentifier: "cellReuseId") as! CardTableViewCell
     
        //let cardName = cardsNS[indexPath.row]
        //cell.name.text = cardName.value(forKey: "nameOfCard") as? String
        
        cell.name.text = myCards[indexPath.row].nameOfCard
        //print("cell text \(String(describing: cell.name.text))")
        
        cell.cardImage.image = UIImage(named:"britt.jpeg")
        
        return cell
    }
    
    func numberOfSections(in tableOfCards: UITableView) -> Int {      return 1   }
  

    
    
    @IBOutlet weak var tableOfCards: UITableView!
    
    //var cardsNS: [NSManagedObject] = []
    
    
    
    @IBAction func filterCards(_ sender: UISegmentedControl) {
    
        switch  sender.selectedSegmentIndex
        {
        case 0:
            //manager.getFilteredCards(context: <#T##NSManagedObjectContext#>, filter: <#T##Int16#>)
            print("zero")
        case 1:
            print("one")
        default:
            break;
        }
    }
    @IBOutlet weak var coloredFilter: UISegmentedControl!
}

