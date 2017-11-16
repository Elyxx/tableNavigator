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
   
    //let segueToEditScreen = "ForEditting"
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
    
    @IBOutlet weak var tableOfCards: UITableView!
    @IBOutlet weak var searchCard: UISearchBar!
     
    override func viewDidLoad() {
        super.viewDidLoad()
              
        tableOfCards.dataSource = self
        tableOfCards.delegate = self
        searchCard.delegate = self
     
        coloredFilter.subviews[4].backgroundColor = UIColor.cYellow
        coloredFilter.subviews[3].backgroundColor = UIColor.cGray
        coloredFilter.subviews[2].backgroundColor = UIColor.cGreen
        coloredFilter.subviews[1].backgroundColor = UIColor.cPink
        coloredFilter.subviews[0].backgroundColor = UIColor.cViolet
        coloredFilter.subviews[5].backgroundColor = .white
        
        navigationItem.titleView = UIImageView(image: UIImage.logo!)
        navigationItem.titleView?.sizeToFit()
        navigationItem.titleView?.isOpaque = true
        
        tableOfCards.backgroundColor = UIColor.cViolet//UIColor(patternImage: UIImage(named: "GrayLeather.jpg")!)
        
        //loadImages()
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
        myCards = manager.getFilteredCards(filter: nil)!
        tableOfCards.reloadData()
        
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
        if segue.identifier == segueToNewCard {
            let editViewController = segue.destination as? StretchViewController
            editViewController?.editingCard = sender as? DiscountCard
        }
        if segue.identifier == segueToCardInfo {
            let pageController = segue.destination as? PageController
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
    /*
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "edit") { (rowAction, indexPath) in
            if self.searchActive == true {
                self.searchActive = false
                self.performSegue(withIdentifier: self.segueToNewCard, sender: self.filtered[indexPath.row])
            }
            else
            {
                self.performSegue(withIdentifier: self.segueToNewCard, sender: self.myCards[indexPath.row])
            }
        }
        editAction.backgroundColor = UIColor.cLightViolet
        
        let shareAction = UITableViewRowAction(style: .normal, title: "share") { (rowAction, indexPath) in
            let alert = UIAlertController(title: "SORRY", message: "service is temporarily unavailable", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
    }*/
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            if self.searchActive == true {
                self.searchActive = false
                self.performSegue(withIdentifier: self.segueToNewCard, sender: self.filtered[indexPath.row])
            }
            else
            {
                self.performSegue(withIdentifier: self.segueToNewCard, sender: self.myCards[indexPath.row])
            }
            success(true)
        })
        editAction.image = UIImage(named: "pen40")
        editAction.backgroundColor = .cGreen
        /*
        let shareAction = UITableViewRowAction(style: .normal, title: "share") { (rowAction, indexPath) in
            //let alert = UIAlertController(title: "SORRY", message: "service is temporarily unavailable", preferredStyle: UIAlertControllerStyle.alert)
            //alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            //self.present(alert, animated: true, completion: nil)
        }
        let lightGreen = UIColor(red: 239.0/255.0, green: 255.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        shareAction.backgroundColor = lightGreen
        
        */
        let deleteAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let alert = UIAlertController(title: "warning", message: "are u sure?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "yep", style: UIAlertActionStyle.destructive, handler: { action in
                    self.manager.deleteCard(cardDeleted: self.myCards[indexPath.row])
                    self.myCards = self.manager.getFilteredCards(filter: self.filter)!
                    self.tableOfCards.reloadData()
               }))
            alert.addAction(UIAlertAction(title: "my mistake", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            success(true)
        })
        deleteAction.image = UIImage(named: "trash40")
        deleteAction.backgroundColor = .cMildRed
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive == true {
            searchActive = false
            performSegue(withIdentifier: "ToPage", sender: self.filtered[indexPath.row])
        }
        else {
            performSegue(withIdentifier: "ToPage", sender: self.myCards[indexPath.row])
        }
    }
    
    
    func tableView(_ tableOfCards: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableOfCards.dequeueReusableCell(withIdentifier: "cellReuseId") as! CardTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
       
        
        if searchActive == true {
            if filtered[indexPath.row].frontImageOfCard != nil{
                cell.imageCell.image = imageManager.getImage(nameOfImage: filtered[indexPath.row].frontImageOfCard!)
            }
            else {
                cell.imageCell.image = UIImage.defaultImage
            }
            cell.nameCell.text = filtered[indexPath.row].nameOfCard
            cell.filterCell.backgroundColor = setColor(number: filtered[indexPath.row].filterByColor)
            cell.descripCell.text = filtered[indexPath.row].descriptionOfCard
            cell.dataCell.text = dateFormatter.string(from: filtered[indexPath.row].dateOfCreation!)
        }
        else{
            if myCards[indexPath.row].frontImageOfCard != nil{
                cell.imageCell.image = imageManager.getImage(nameOfImage: myCards[indexPath.row].frontImageOfCard!)
            }
            else {
                cell.imageCell.image = UIImage.defaultImage
            }
            
            cell.nameCell.text = myCards[indexPath.row].nameOfCard
            cell.filterCell.backgroundColor = setColor(number: myCards[indexPath.row].filterByColor)
            cell.descripCell.text = myCards[indexPath.row].descriptionOfCard
            cell.dataCell.text = dateFormatter.string(from: myCards[indexPath.row].dateOfCreation!)
        }
        return cell
    }
    
    func numberOfSections(in tableOfCards: UITableView) -> Int {      return 1   }
    
    @IBAction func filterCards(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { filter = nil}
        else {filter = String(sender.selectedSegmentIndex - 1)}
        myCards = manager.getFilteredCards(filter: filter)!
        tableOfCards.reloadData()
       
    }
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    @IBAction func sorting(_ sender: UIBarButtonItem) {
        
        let button = UIButton(frame: CGRect(x: 0, y: 15, width: 100, height: 50))
        button.backgroundColor = .cViolet
        button.setTitle("ascending", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
 
        UIView.animate(withDuration: 1, delay: 0, animations: {   button.center.y += 50 },
         completion: nil    )
        
        /*UIView.animate(withDuration: 0.5, delay: 0.4,
         options: [.repeat, .autoreverse],
         animations: {
         self.imageCell.center.x += self.dataCell.bounds.width
         },
         completion: nil
         )*/
        
       
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // add the actions (buttons)
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 280);
        
        let width : NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 180);
        
        alert.view.addConstraint(height);
        
        alert.view.addConstraint(width);
        
        alert.addAction(UIAlertAction(title: "ascending", style: UIAlertActionStyle.default, handler: { action in
            self.myCards = self.myCards.sorted { (firstCard, secndCard) -> Bool in
                return firstCard.nameOfCard?.caseInsensitiveCompare(secndCard.nameOfCard!) == ComparisonResult.orderedAscending
            }
            self.tableOfCards.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "discending", style: UIAlertActionStyle.default, handler: { action in
            self.myCards = self.myCards.sorted { (firstCard, secndCard) -> Bool in
                return firstCard.nameOfCard?.caseInsensitiveCompare(secndCard.nameOfCard!) == ComparisonResult.orderedDescending
            }
            self.tableOfCards.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "earlier first", style: UIAlertActionStyle.default, handler: { action in
            self.myCards = self.myCards.sorted { (firstCard, secndCard) -> Bool in
                return (firstCard.dateOfCreation)?.compare((secndCard.dateOfCreation)!) == ComparisonResult.orderedAscending
            }
            self.tableOfCards.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "later first", style: UIAlertActionStyle.default, handler: { action in
            self.myCards = self.myCards.sorted { (firstCard, secndCard) -> Bool in
                return (firstCard.dateOfCreation)?.compare((secndCard.dateOfCreation)!) == ComparisonResult.orderedDescending
            }
            self.tableOfCards.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    /*
    @IBAction func scaleTable(_ sender: UIPinchGestureRecognizer) {
        
        tableOfCards.transform = CGAffineTransform.identity.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
        print("scale")
    }
   */
    func setColor(number: String?) -> UIColor{
        switch number {
        case "0"?:
            return UIColor.cYellow
        case "1"?:
            return UIColor.cGray
        case "2"?:
            return UIColor.cGreen
        case "3"?:
            return UIColor.cPink
        case "4"?:
            return UIColor.cViolet
        default:
            return .white
        }
    }
    @IBOutlet weak var coloredFilter: UISegmentedControl!
    func loadImages(){
        if let imageToLoad = UIImage(named:"chernyj_strizh.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"kitty.jpeg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"britt.jpeg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"flag.jpeg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"kitten.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"lili.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"paper.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"Apple.png"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"chernyj_strizh.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        
    }
}

