//
//  Item+CoreDataProperties.swift
//  SwiftUICoreDataRelationshipsMVVM
//
//  Created by Anton Standwerth on 2020-07-30.
//  Copyright © 2020 Standwerth. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var itemTitle: String?
    @NSManaged public var itemDesc: String?
    @NSManaged public var itemID: UUID?
    @NSManaged public var ofList: List?

}
