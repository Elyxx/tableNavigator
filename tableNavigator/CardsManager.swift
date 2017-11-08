//
//  CardsManager.swift
//  tableNavigator
//
//  Created by adminaccount on 10/30/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CardsManager{
    var context:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func addNewCard(name: String? = nil, descrip: String? = nil, filter: String? = nil, frontIMG: String? = nil, backIMG: String? = nil, barcodeIMG: NSData? = nil){
        let entity =  NSEntityDescription.entity(forEntityName: "DiscountCard", in: context)
        let newCard = DiscountCard(entity: entity!, insertInto:context)
        newCard.nameOfCard = name
        newCard.frontImageOfCard = frontIMG
        //newCard.setValue(backIMG, forKey: "backImageOfCard")
        //newCard.setValue(barcodeIMG, forKey: "barcode")
        newCard.descriptionOfCard = descrip
        newCard.filterByColor = filter
        newCard.dateOfCreation = Date()
        //var error: NSError?
        try! context.save()
    }
    func editExisting(card: DiscountCard, name: String? = nil, descrip: String? = nil, filter: String? = nil, frontIMG: String? = nil, backIMG: String? = nil, barcodeIMG: NSData? = nil){
        card.nameOfCard = name
        card.descriptionOfCard = descrip
        card.filterByColor = filter
        card.frontImageOfCard = frontIMG
        //!!!!!!!
        try! context.save()
    }
    func getFilteredCards(filter: String? = nil)->[DiscountCard]?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiscountCard")
        if filter != nil {
            fetchRequest.predicate = NSPredicate(format: "filterByColor == %@", filter!)
        }
        //var error: NSError?
        var fetchedResults: [DiscountCard]? = nil
        fetchedResults = try! context.fetch(fetchRequest) as? [DiscountCard]
        return fetchedResults
    }    
    func deleteCard(cardDeleted: DiscountCard){
         context.delete(cardDeleted)
         try! context.save()
    }
}

