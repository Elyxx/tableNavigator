//
//  DiscountCard+CoreDataClass.swift
//  tableNavigator
//
//  Created by adminaccount on 11/1/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//
//

import Foundation
import CoreData

@objc(DiscountCard)

public class DiscountCard: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiscountCard> {
        return NSFetchRequest<DiscountCard>(entityName: "DiscountCard")
    }
  
    @NSManaged public var descriptionOfCard: String?
    @NSManaged public var filterByColor: String?
    @NSManaged public var nameOfCard: String?
    @NSManaged public var frontImageOfCard: String?
    @NSManaged public var backImageOfCard: String?
    @NSManaged public var barcode: NSData?
    @NSManaged public var dateOfCreation: Date?

    /*override public func awakeFromInsert() {
        super.awakeFromInsert()
        dateOfCreation = Date()
    }
    
    public override init() {
        descriptionOfCard = nil
        filterByColor = 0
        nameOfCard = ""
        frontImageOfCard = nil
        backImageOfCard = nil
        barcode = nil
        dateOfCreation = Date()
    }
    func createNewCard(context: NSManagedObjectContext)->DiscountCard?{
        let entity =  NSEntityDescription.entity(forEntityName: "DiscountCard", in: context)
        let newCard = NSManagedObject(entity: entity!, insertInto:context)
        //var error: NSError?
        try! context.save()
        return newCard as? DiscountCard
    }*/
}
