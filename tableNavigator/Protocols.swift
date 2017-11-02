//
//  Protocols.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import Foundation
import CoreData

protocol FillTheTable:class {
    var cardsNS: [NSManagedObject] {get set}
    var names: [String] {get set}
  
}
protocol sendCard: class {
    func initCard (cardID: NSManagedObjectID)
}
