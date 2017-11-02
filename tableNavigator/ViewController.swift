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
   
    var filter: String? = nil
    var delegate: sendCard?
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
            //editViewController?.delegate = self
        }
    }*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        myCards = manager.getFilteredCards(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, filter: filter)!
        //unwrap
        tableOfCards.reloadData()
    }
    
    func tableView(_ tableOfCards: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myCards.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "edit") { (rowAction, indexPath) in
            //let predicat = self.myCards[indexPath.row].nameOfCard
            
            //self.manager.setActiveCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, stringPredicat: predicat!)
            
            self.performSegue(withIdentifier: "ToEdit", sender: self)
            //self.editViewController?.initCard(cardID: self.myCards[indexPath.row].objectID)
        }
        let lightViolet = UIColor(red: 229.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        editAction.backgroundColor = lightViolet
        
        let shareAction = UITableViewRowAction(style: .normal, title: "share") { (rowAction, indexPath) in
            //print(myCards.nameOfCard)
        }
        let lightGreen = UIColor(red: 239.0/255.0, green: 255.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        shareAction.backgroundColor = lightGreen
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "delete") { (rowAction, indexPath) in
            //let predicat = self.myCards[indexPath.row].nameOfCard
            //unwrap
            self.manager.deleteCard(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, cardDeleted: self.myCards[indexPath.row])
            //if more then one crash accured
            self.myCards = self.manager.getFilteredCards(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, filter: self.filter)!
            self.tableOfCards.reloadData()
        }
        let lightRed = UIColor(red: 255.0/255.0, green: 236.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = lightRed
        
        return [editAction, shareAction, deleteAction]
    }
    
    func tableView(_ tableOfCards: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableOfCards.dequeueReusableCell(withIdentifier: "cellReuseId") as! CardTableViewCell
        
        cell.nameCell.text = myCards[indexPath.row].nameOfCard
        
        cell.filterCell.backgroundColor = setColor(number: myCards[indexPath.row].filterByColor)
        
        cell.descripCell.text = myCards[indexPath.row].descriptionOfCard
        cell.imageCell.image = UIImage(named:"britt.jpeg")
        
        return cell
    }
    
    func numberOfSections(in tableOfCards: UITableView) -> Int {      return 1   }
    
    @IBOutlet weak var tableOfCards: UITableView!
    
    @IBAction func filterCards(_ sender: UISegmentedControl) {
        filter = String(sender.selectedSegmentIndex)
        myCards = manager.getFilteredCards(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, filter: filter)!
        tableOfCards.reloadData()
    }
    func setColor(number: String?) -> UIColor{
        switch number {
        case "0"?:
            return UIColor(red: 255.0/255.0, green: 236.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        case "1"?:
            return UIColor(red: 230.0/255.0, green: 236.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        case "2"?:
            return UIColor(red: 235.0/255.0, green: 255.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        case "3"?:
            return UIColor(red: 255.0/255.0, green: 236.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        case "4"?:
            return UIColor(red: 255.0/255.0, green: 250.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        default:
            return .red
        }
    }
    @IBOutlet weak var coloredFilter: UISegmentedControl!
}

