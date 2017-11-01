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
    @NSManaged public var filterByColor: Int16
    @NSManaged public var nameOfCard: String?
    @NSManaged public var frontImageOfCard: String?
    @NSManaged public var backImageOfCard: String?
    @NSManaged public var barcode: NSData?
}
