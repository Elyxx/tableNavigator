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
    
    //weak var delegate: SendCard?
    
    let segueToEditScreen = "ForEditting"
    let segueToNewCard = "ToEdit"
    let segueToCardInfo = "ToPage"
    
    var manager = CardsManager()
    var imageManager = FileManaging()
    var myCards = [DiscountCard]()
   
    var data = [String] ()
    var searchActive : Bool = false
    var filter: String? = nil
    
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
        /*if (segue.identifier == segueToNewCard){
            let editViewController = segue.destination as? EditViewController
            //editViewController?.delegate = self as? SendCard
        }*/
        if (segue.identifier == segueToEditScreen){
            let editViewController = segue.destination as? EditViewController
            //editViewController?.delegate = self as? SendCard
            editViewController?.editingCard = sender as? DiscountCard
        }
        if (segue.identifier == segueToCardInfo) {
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
            self.performSegue(withIdentifier: self.segueToEditScreen, sender: self.myCards[indexPath.row])
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
            if myCards[indexPath.row].frontImageOfCard != nil{
                cell.imageCell.image = imageManager.getImage(nameOfImage: myCards[indexPath.row].frontImageOfCard!)
                print("the adress is")
                print(myCards[indexPath.row].frontImageOfCard!)
            }
            else {
                cell.imageCell.image = UIImage(named:"default.jpeg")
            }
            cell.nameCell.text = filtered[indexPath.row].nameOfCard
            cell.filterCell.backgroundColor = setColor(number: filtered[indexPath.row].filterByColor)
            cell.descripCell.text = filtered[indexPath.row].descriptionOfCard
            cell.dataCell.text = dateFormatter.string(from: filtered[indexPath.row].dateOfCreation!)
        }
        else{
            if myCards[indexPath.row].frontImageOfCard != nil{
                cell.imageCell.image = imageManager.getImage(nameOfImage: myCards[indexPath.row].frontImageOfCard!)
                print("the adress is")
                print(myCards[indexPath.row].frontImageOfCard!)
            }
            else {
                cell.imageCell.image = UIImage(named:"default.jpeg")
            }
            
            cell.nameCell.text = myCards[indexPath.row].nameOfCard
            cell.filterCell.backgroundColor = setColor(number: myCards[indexPath.row].filterByColor)
            cell.descripCell.text = myCards[indexPath.row].descriptionOfCard
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
        /*
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                print("Found \(item)")
            }
        } catch {    print("no such file")    }
        //UIImageWriteToSavedPhotosAlbum(UIImage(named:"chernyj_strizh.jpg")!, nil, nil, nil)
 */
        
    }
    
    @IBAction func sorting(_ sender: UIBarButtonItem) {
       
        let alert = UIAlertController(title: "Notice", message: "Lauching this missile will destroy the entire universe. Is this what you intended to do?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 200);
        
        let width : NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 300);
        
        alert.view.addConstraint(height);
        
        alert.view.addConstraint(width);
        
        alert.addAction(UIAlertAction(title: "ascending names", style: UIAlertActionStyle.default, handler: { action in
            self.myCards = self.myCards.sorted { (firstCard, secndCard) -> Bool in
                return firstCard.nameOfCard?.caseInsensitiveCompare(secndCard.nameOfCard!) == ComparisonResult.orderedAscending
            }
            self.tableOfCards.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "discending names", style: UIAlertActionStyle.default, handler: { action in
            self.myCards = self.myCards.sorted { (firstCard, secndCard) -> Bool in
                return firstCard.nameOfCard?.caseInsensitiveCompare(secndCard.nameOfCard!) == ComparisonResult.orderedAscending
            }
            self.tableOfCards.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "ascending data", style: UIAlertActionStyle.default, handler: { action in
            self.myCards = self.myCards.sorted { (firstCard, secndCard) -> Bool in
                return firstCard.nameOfCard?.caseInsensitiveCompare(secndCard.nameOfCard!) == ComparisonResult.orderedAscending
            }
            self.tableOfCards.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "discending data", style: UIAlertActionStyle.default, handler: { action in
            self.myCards = self.myCards.sorted { (firstCard, secndCard) -> Bool in
                return firstCard.nameOfCard?.caseInsensitiveCompare(secndCard.nameOfCard!) == ComparisonResult.orderedAscending
            }
            self.tableOfCards.reloadData()
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        /*
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SortPopUp") as! PopViewController
        popController.modalPresentationStyle = .popover
        popController.view.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
            //.preferredContentSize = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
          */
       /* let popoverPresentationViewController = popController.popoverPresentationController
        popoverPresentationViewController?.permittedArrowDirections = .any
        popoverPresentationViewController?.delegate = self
        popoverPresentationController?.sourceRect = sender.frame
        presentViewController(playerInformationViewController, animated: true, completion: nil)
 
        myCards = myCards.sorted { (firstCard, secndCard) -> Bool in
            return firstCard.nameOfCard?.caseInsensitiveCompare(secndCard.nameOfCard!) == ComparisonResult.orderedAscending
        }
        tableOfCards.reloadData()*/
        
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

