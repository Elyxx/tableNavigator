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

    func addNewCard(name: String? = nil, descrip: String? = nil, filter: String? = nil, frontIMG: String? = nil, backIMG: String? = nil, barcodeIMG: String? = nil){
        let entity =  NSEntityDescription.entity(forEntityName: "DiscountCard", in: context)
        let newCard = DiscountCard(entity: entity!, insertInto:context)
        newCard.nameOfCard = name
        newCard.frontImageOfCard = frontIMG
        newCard.backImageOfCard = backIMG
        newCard.barcode = barcodeIMG
        newCard.descriptionOfCard = descrip
        newCard.filterByColor = filter
        newCard.dateOfCreation = Date()
        //var error: NSError?
        try! context.save()
    }
    func editExisting(card: DiscountCard, name: String? = nil, descrip: String? = nil, filter: String? = nil, frontIMG: String? = nil, backIMG: String? = nil, barcodeIMG: String? = nil){
        if name != nil { card.nameOfCard = name }
        if descrip != nil { card.descriptionOfCard = descrip }
        if filter != nil { card.filterByColor = filter }
        if frontIMG != nil { card.frontImageOfCard = frontIMG }
        if backIMG != nil {card.backImageOfCard = backIMG }
        if barcodeIMG != nil { card.barcode = barcodeIMG }      
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

