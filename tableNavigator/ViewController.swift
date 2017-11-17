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
    var buttons = [UIButton]()
    var searchActive : Bool = false
    var sortFinished :Bool = false
    var filter: Int32? = nil
    
    var filtered = [DiscountCard]()
   
    @IBOutlet weak var tableOfCards: UITableView!
    @IBOutlet weak var searchCard: UISearchBar!
    @IBOutlet weak var coloredFilter: UISegmentedControl!
    
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
        
        tableOfCards.backgroundColor = UIColor(patternImage: UIImage(named: "GrayLeather.jpg")!)
        
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
        
        let shareAction = UIContextualAction(style: .normal, title: "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
   /*         let alert = UIAlertController(title: "SORRY", message: "service is temporarily unavailable", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)*/
          let card = self.myCards[indexPath.row]
            let activity = UIActivityViewController(activityItems: [card.nameOfCard as Any, card.descriptionOfCard as Any,
                 self.imageManager.getImage(nameOfImage: card.frontImageOfCard!) as Any], applicationActivities: nil)
             activity.popoverPresentationController?.sourceView = self.view
            self.present(activity, animated: true, completion: nil)
            success(true)
        })
        shareAction.image = UIImage(named: "share40")
        shareAction.backgroundColor = .cYellow
    
        let deleteAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let alert = UIAlertController(title: "warning", message: "are u sure?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "yep", style: UIAlertActionStyle.destructive, handler: { action in
                if self.searchActive == true {
                    self.manager.deleteCard(cardDeleted: self.filtered[indexPath.row])
                    self.filtered = self.manager.getFilteredCards(filter: self.filter)!
                    self.tableOfCards.reloadData()
                }
                else{
                    self.manager.deleteCard(cardDeleted: self.myCards[indexPath.row])
                    self.myCards = self.manager.getFilteredCards(filter: self.filter)!
                    self.tableOfCards.reloadData()
                }
               }))
            alert.addAction(UIAlertAction(title: "my mistake", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            success(true)
        })
        deleteAction.image = UIImage(named: "trash40")
        deleteAction.backgroundColor = .cMildRed
        return UISwipeActionsConfiguration(actions: [editAction, shareAction, deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive == true {
            searchActive = false
            performSegue(withIdentifier: segueToCardInfo, sender: self.filtered[indexPath.row])
        }
        else {
            performSegue(withIdentifier: segueToCardInfo, sender: self.myCards[indexPath.row])
        }
    }
    
    
    func tableView(_ tableOfCards: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableOfCards.dequeueReusableCell(withIdentifier: "cellReuseId") as! CardTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
       
        
        if searchActive == true {
            if filtered[indexPath.row].previewImageOfCard != nil{
                cell.imageCell.image = imageManager.getImage(nameOfImage: filtered[indexPath.row].previewImageOfCard!)
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
            if myCards[indexPath.row].previewImageOfCard != nil{
                cell.imageCell.image = imageManager.getImage(nameOfImage: myCards[indexPath.row].previewImageOfCard!)
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
        else {filter = Int32( sender.selectedSegmentIndex - 1 )}
        myCards = manager.getFilteredCards(filter: filter)!
        tableOfCards.reloadData()
       
    }
    @objc func buttonAcsending(sender: UIButton!) {
        sortFinished = false
        removeMenu()
        myCards = myCards.sorted { (firstCard, secndCard) -> Bool in
            return firstCard.nameOfCard?.caseInsensitiveCompare(secndCard.nameOfCard!) == ComparisonResult.orderedAscending
        }
        tableOfCards.reloadData()
    }
    @objc func buttonDiscending(sender: UIButton!) {
        sortFinished = false
        removeMenu()
        myCards = myCards.sorted { (firstCard, secndCard) -> Bool in
            return firstCard.nameOfCard?.caseInsensitiveCompare(secndCard.nameOfCard!) == ComparisonResult.orderedDescending
        }
        tableOfCards.reloadData()
    }
    @objc func buttonEalier(sender: UIButton!) {
        sortFinished = false
        removeMenu()
        myCards = myCards.sorted { (firstCard, secndCard) -> Bool in
            return (firstCard.dateOfCreation)?.compare((secndCard.dateOfCreation)!) == ComparisonResult.orderedAscending
        }
        tableOfCards.reloadData()
    }
    @objc func buttonLater(sender: UIButton!) {
        sortFinished = false
        removeMenu()
        myCards = myCards.sorted { (firstCard, secndCard) -> Bool in
            return (firstCard.dateOfCreation)?.compare((secndCard.dateOfCreation)!) == ComparisonResult.orderedDescending
        }
        tableOfCards.reloadData()
    }
    @IBAction func sorting(_ sender: UIBarButtonItem) {
        
        if sortFinished == false{
            sortFinished = true
            
            buttons.append(createMenuButton(name: "later first"))
            buttons.append(createMenuButton(name: "earlier first"))
            buttons.append(createMenuButton(name: "discending"))
            buttons.append(createMenuButton(name: "ascending"))
            
            buttons[0].addTarget(self, action: #selector(buttonLater), for: .touchUpInside)
            view.addSubview(buttons[0])
            UIView.animate(withDuration: 0.8, delay: 0, animations: {   self.buttons[0].center.y += 200 },  completion: nil )
            
            
            buttons[1].addTarget(self, action: #selector(buttonEalier), for: .touchUpInside)
            view.addSubview(buttons[1])
            UIView.animate(withDuration: 0.6, delay: 0, animations: {   self.buttons[1].center.y += 150 },  completion: nil )
            
            
            buttons[2].addTarget(self, action: #selector(buttonDiscending), for: .touchUpInside)
            view.addSubview(buttons[2])
            UIView.animate(withDuration: 0.4, delay: 0, animations: {   self.buttons[2].center.y += 100 },  completion: nil )
            
            
            buttons[3].addTarget(self, action: #selector(buttonAcsending), for: .touchUpInside)
            view.addSubview(buttons[3])
            UIView.animate(withDuration: 0.2, delay: 0, animations: {   self.buttons[3].center.y += 50 },  completion: nil )
        }
        else {
            removeMenu()
        }
    }
      
    
    func createMenuButton(name: String)->UIButton{
        let button = UIButton(frame: CGRect(x: 0, y: 10, width: 100, height: 50))
        button.backgroundColor = .cGray
        button.setTitleColor(.black, for: .normal)
        button.setTitle(name, for: .normal)
        return button
    }
    func removeMenu(){
        for button in buttons{
            button.removeFromSuperview()
        }
        buttons = []
        sortFinished = false
    }
    func setColor(number: Int32) -> UIColor{
        switch number {
        case 0:
            return UIColor.cYellow
        case 1:
            return UIColor.cGray
        case 2:
            return UIColor.cGreen
        case 3:
            return UIColor.cPink
        case 4:
            return UIColor.cViolet
        default:
            return .white
        }
    }
    
    
    func loadImages(){
        if let imageToLoad = UIImage(named:"panda.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"spar.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"sport.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"pass.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"walker.png"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"karavan.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"premium.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"joiner.jpg"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
        if let imageToLoad = UIImage(named:"parfum.png"){
            UIImageWriteToSavedPhotosAlbum(imageToLoad, nil, nil, nil)
        }
    }
}

