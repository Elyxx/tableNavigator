//
//  CardsManager.swift
//  tableNavigator
//
//  Created by adminaccount on 10/30/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import Foundation
import CoreData

class CardsManager{
    func addNewCard(context: NSManagedObjectContext, name: String? = nil, descrip: String? = nil, filter: String? = nil, frontIMG: String? = nil, backIMG: String? = nil, barcodeIMG: NSData? = nil){
        let entity =  NSEntityDescription.entity(forEntityName: "DiscountCard", in: context)
        let newCard = NSManagedObject(entity: entity!, insertInto:context)
        newCard.setValue(name, forKey: "nameOfCard")
        //newCard.setValue(frontIMG, forKey: "frontImageOfCard")
        //newCard.setValue(backIMG, forKey: "backImageOfCard")
        //newCard.setValue(barcodeIMG, forKey: "barcode")
        newCard.setValue(descrip, forKey: "descriptionOfCard")
        newCard.setValue(filter, forKey: "filterByColor")
        newCard.setValue(Date(), forKey: "dateOfCreation")
     
        //var error: NSError?
        try! context.save()
    }
    func editExisting(context: NSManagedObjectContext, card: DiscountCard, name: String? = nil, descrip: String? = nil, filter: String? = nil, frontIMG: String? = nil, backIMG: String? = nil, barcodeIMG: NSData? = nil){
        card.nameOfCard = name
        card.descriptionOfCard = descrip
        card.filterByColor = filter
        try! context.save()
    }
    func getFilteredCards(context: NSManagedObjectContext, filter: String? = nil)->[DiscountCard]?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiscountCard")
        if filter != nil {
            fetchRequest.predicate = NSPredicate(format: "filterByColor == %@", filter!)
        }
        //var error: NSError?
        var fetchedResults: [DiscountCard]? = nil
        do {
            fetchedResults = try context.fetch(fetchRequest) as? [DiscountCard] 
            for item in fetchedResults!{
                if item.dateOfCreation == nil{
                    item.dateOfCreation = Date()
                }
            }
        }
        catch{
            print("Could not fetch")
        }
        return fetchedResults
    }    
    func deleteCard(context: NSManagedObjectContext, cardDeleted: DiscountCard){
         context.delete(cardDeleted)
         do {            try context.save()         } catch {            print("wrong deleting")         }
    }
}

