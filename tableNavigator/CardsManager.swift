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
    
    
    func createNewCard(context: NSManagedObjectContext)->NSManagedObjectID{
        let entity =  NSEntityDescription.entity(forEntityName: "DiscountCard", in: context)
        let newCard = NSManagedObject(entity: entity!, insertInto:context)
        //var error: NSError?
        try! context.save()
        return newCard.objectID
    }
    
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
    
    func editExistingCard(){
        /*
 // Предполагаем, что тип имеет ссылку на контекст
 
 // Предполагаем, что свойство objectIDFromNSManagedObject объекта NSManagedObject доступно
 // Как вариант, вы можете выставить выражение предиката,
 // которое является достаточно точным, чтобы иметь возможность выбрать только одну сущность
 
 let predicate = NSPredicate(format: "objectID == %@", objectIDFromNSManagedObject)
 
 let fetchRequest = NSFetchRequest(entityName: "MyEntity")
 fetchRequest.predicate = predicate
 
 do {
 let fetchedEntities = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [MyEntity]
 fetchedEntities.first?.FirstPropertyToUpdate = NewValue
 fetchedEntities.first?.SecondPropertyToUpdate = NewValue
 // ... Обновляем новые свойства с новыми значениями
 } catch {
 // что-то делаем в зависимости от ошибки
 }
 
 do {
 try self.managedObjectContext.save()
 } catch {
 // что-то делаем в зависимости от ошибки
 }*/
        //entity.FirstPropertyToUpdate = NewValue
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

    
    var activeCard: NSManagedObject? = nil
}

extension DiscountCard {
    
}
