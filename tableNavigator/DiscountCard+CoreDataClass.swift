//
//  DiscountCard+CoreDataClass.swift
//  tableNavigator
//
//  Created by adminaccount on 11/16/17.
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
    
    @NSManaged public var backImageOfCard: String?
    @NSManaged public var barcode: String?
    @NSManaged public var dateOfCreation: Date?
    @NSManaged public var filterByColor: Int32
    @NSManaged public var frontImageOfCard: String?
    @NSManaged public var nameOfCard: String?
    @NSManaged public var previewImageOfCard: String?
    @NSManaged public var descriptionOfCard: String?
}
