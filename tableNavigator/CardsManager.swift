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
    
    func getActiveCard(context: NSManagedObjectContext)->NSManagedObject?{
        return activeCard
    }
    
    func addNewCard(context: NSManagedObjectContext, name: String){
        let entity =  NSEntityDescription.entity(forEntityName: "DiscountCard", in: context)
        let newCard = NSManagedObject(entity: entity!, insertInto:context)
        newCard.setValue(name, forKey: "nameOfCard")
        
        //var error: NSError?
      
        try! context.save()
    }
    func setActiveCard(context: NSManagedObjectContext, stringPredicat: String){
     
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiscountCard")
        fetchRequest.predicate = NSPredicate(format: "nameOfCard == %@", stringPredicat)
      
        do {
            let fetchedResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            activeCard = (fetchedResults?.first)!
            print("we have a card")
        } catch {
            activeCard = nil
            print("there was no card")
        }
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
    func getCards(context: NSManagedObjectContext)->[NSManagedObject]?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiscountCard")
        //var error: NSError?
        var fetchedResults: [NSManagedObject]? = nil
        do {
            fetchedResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            cardsNS = fetchedResults!////
        }
        catch{
            fetchedResults = nil
            print("Could not fetch")
        }
        //print("here is what we had stored")
        //for item in cardsNS {            print(item.value(forKey: "nameOfCard"))        }
         return fetchedResults
    }
    func getOneCard(context: NSManagedObjectContext, stringPredicat: String)->NSManagedObject?{
        var card: NSManagedObject? = nil
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiscountCard")
        fetchRequest.predicate = NSPredicate(format: "nameOfCard == %@", stringPredicat)
        do {
            let fetchedResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            card = (fetchedResults?.first)!
        } catch {card = nil}
        do {         try context.save()         } catch {            print("wrong deleting")         }
        return card
    }
    
    func deleteCard(context: NSManagedObjectContext, stringPredicat: String){
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiscountCard")
         fetchRequest.predicate = NSPredicate(format: "nameOfCard == %@", stringPredicat)
         do {
            let fetchedEntities = try context.fetch(fetchRequest) as? [NSManagedObject]
            for fetchedCard in fetchedEntities! {
                  context.delete(fetchedCard)
                }
             /*if let entityToDelete = fetchedEntities?.first {      print("inside")
                context.delete(entityToDelete)         }*/
         } catch {    // что-то делаем в зависимости от ошибки
         }
         do {         try context.save()         } catch {            print("wrong deleting")         }
    }
    var cardsNS: [NSManagedObject] = []
    
    var activeCard: NSManagedObject? = nil
}

extension DiscountCard {
    
}
