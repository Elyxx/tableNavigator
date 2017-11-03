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
    
    //static var activeCard: NSManagedObject? = nil
    /*
    func createNewCard(context: NSManagedObjectContext)->NSManagedObjectID{
        let entity =  NSEntityDescription.entity(forEntityName: "DiscountCard", in: context)
        let newCard = NSManagedObject(entity: entity!, insertInto:context)
        //var error: NSError?
        try! context.save()
        return newCard.objectID
    }
    */
    func addNewCard(context: NSManagedObjectContext, name: String? = nil, descrip: String? = nil, filter: String? = nil, frontIMG: String? = nil, backIMG: String? = nil, barcodeIMG: NSData? = nil){
        let entity =  NSEntityDescription.entity(forEntityName: "DiscountCard", in: context)
        let newCard = NSManagedObject(entity: entity!, insertInto:context)
        newCard.setValue(name, forKey: "nameOfCard")
        //newCard.setValue(frontIMG, forKey: "frontImageOfCard")
        //newCard.setValue(backIMG, forKey: "backImageOfCard")
        //newCard.setValue(barcodeIMG, forKey: "barcode")
        newCard.setValue(descrip, forKey: "descriptionOfCard")
        newCard.setValue(filter, forKey: "filterByColor")
        //newCard.setValue(Data(), forKey: "dateOfCreation")
     
        //var error: NSError?
        try! context.save()
    }
    
    func editExisting(context: NSManagedObjectContext, card: DiscountCard){
         //card.nameOfCard = ""
         //card.descriptionOfCard = ""
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
            fetchedResults = try context.fetch(fetchRequest) as? [DiscountCard] //[NSManagedObject]
        }
        catch{
            print("Could not fetch")
        }
        return fetchedResults
    }
    
    func getCards(context: NSManagedObjectContext)->[DiscountCard]?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiscountCard")
        //var error: NSError?
        var fetchedResults: [DiscountCard]? = nil
        do {
            fetchedResults = try context.fetch(fetchRequest) as? [DiscountCard] //[NSManagedObject]
        }
        catch{
            fetchedResults = nil
            print("Could not fetch")
        }
        return fetchedResults
    }
    /*
    func getOneCard(context: NSManagedObjectContext, stringPredicat: String)->NSManagedObject?{
        var card: NSManagedObject? = nil
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiscountCard")
        fetchRequest.predicate = NSPredicate(format: "objectID == %@", stringPredicat)
        do {
            let fetchedResults = try context.fetch(fetchRequest) as? [DiscountCard]
            card = (fetchedResults?.first)!
        } catch {
            card = nil}
        do {         try context.save()         } catch {            print("wrong deleting")         }
        return card
    }
    */
    func deleteCard(context: NSManagedObjectContext, cardDeleted: DiscountCard){
         context.delete(cardDeleted)
         do {
            try context.save()         } catch {            print("wrong deleting")         }
    }
    
    func setActiveCard(context: NSManagedObjectContext, card: DiscountCard){
        //self.activeCard = card
    }

    
    
}

extension DiscountCard {
    
}
