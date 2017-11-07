//
//  ViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
//import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    var manager = CardsManager()
    var myCards = [DiscountCard]()
   
    var data = [String] ()
    var searchActive : Bool = false
    var filter: String? = nil
    var delegate: SendCard?
    
    var filtered = [DiscountCard]()
    
    var editViewController: EditViewController? = nil
    
    @IBOutlet weak var searchCard: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        tableOfCards.dataSource = self //???
        tableOfCards.delegate = self
        searchCard.delegate = self

        let lightRed = UIColor(red: 255.0/255.0, green: 236.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        let lightGreen = UIColor(red: 239.0/255.0, green: 255.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        
        var subViewOfSegment: UIView = coloredFilter.subviews[1] as UIView
        subViewOfSegment.backgroundColor = lightGreen
        
        subViewOfSegment = coloredFilter.subviews[3] as UIView
        subViewOfSegment.backgroundColor = lightRed
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
        filtered = myCards.filter({ (card) -> Bool in
            let tmp: NSString = (card.nameOfCard as NSString?)!
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        print(searchText)
        if (filtered.count == 0) {
            searchActive = false;
        } else {
            searchActive = true;
        }
        tableOfCards.reloadData()
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToEdit"){
            let editViewController = segue.destination as? EditViewController
            editViewController?.delegate = self as? SendCard
        }
        if (segue.identifier == "ForEditting"){
            let editViewController = segue.destination as? EditViewController
            editViewController?.delegate = self as? SendCard
            editViewController?.editingCard = sender as? DiscountCard
        }
        if (segue.identifier == "ToPage"){
            let pageController = segue.destination as? PageController
            //pageController?.delegate = self as? PageController
            pageController?.editingCard = sender as? DiscountCard
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        myCards = manager.getFilteredCards(filter: filter)!
        tableOfCards.reloadData()
    }
    
    func tableView(_ tableOfCards: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return myCards.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "edit") { (rowAction, indexPath) in
            self.performSegue(withIdentifier: "ForEditting", sender: self.myCards[indexPath.row])
        }
        let lightViolet = UIColor(red: 229.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        editAction.backgroundColor = lightViolet
        
        let shareAction = UITableViewRowAction(style: .normal, title: "share") { (rowAction, indexPath) in
            }
        let lightGreen = UIColor(red: 239.0/255.0, green: 255.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        shareAction.backgroundColor = lightGreen
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "delete") { (rowAction, indexPath) in
            self.manager.deleteCard(cardDeleted: self.myCards[indexPath.row])
            self.myCards = self.manager.getFilteredCards(filter: self.filter)!
            self.tableOfCards.reloadData()
        }
        let lightRed = UIColor(red: 255.0/255.0, green: 236.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = lightRed
        
        return [editAction, shareAction, deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row's been selected")
        performSegue(withIdentifier: "ToPage", sender: self.myCards[indexPath.row])
    }
    
    func tableView(_ tableOfCards: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableOfCards.dequeueReusableCell(withIdentifier: "cellReuseId") as! CardTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
       
        
        if searchActive == true {
            //filtered mas
            cell.nameCell.text = filtered[indexPath.row].nameOfCard
            
            cell.filterCell.backgroundColor = setColor(number: filtered[indexPath.row].filterByColor)
            
            cell.descripCell.text = filtered[indexPath.row].descriptionOfCard
            cell.imageCell.image = UIImage(named:"kitten.jpeg")
            cell.dataCell.text = dateFormatter.string(from: filtered[indexPath.row].dateOfCreation!)
        }
        else{
            cell.nameCell.text = myCards[indexPath.row].nameOfCard
            
            cell.filterCell.backgroundColor = setColor(number: myCards[indexPath.row].filterByColor)
            
            cell.descripCell.text = myCards[indexPath.row].descriptionOfCard
            cell.imageCell.image = UIImage(named:"britt.jpeg")
            cell.dataCell.text = dateFormatter.string(from: myCards[indexPath.row].dateOfCreation!)
        }
        return cell
    }
    
    func numberOfSections(in tableOfCards: UITableView) -> Int {      return 1   }
    
    @IBOutlet weak var tableOfCards: UITableView!
    
    @IBAction func filterCards(_ sender: UISegmentedControl) {
        filter = String(sender.selectedSegmentIndex)
        myCards = manager.getFilteredCards(filter: filter)!
        tableOfCards.reloadData()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                print("Found \(item)")
            }
        } catch {    print("no such file")    }
        UIImageWriteToSavedPhotosAlbum(UIImage(named:"chernyj_strizh.jpg")!, nil, nil, nil)
        
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

