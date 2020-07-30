//
//  List+CoreDataProperties.swift
//  SwiftUICoreDataRelationshipsMVVM
//
//  Created by Anton Standwerth on 2020-07-30.
//  Copyright © 2020 Standwerth. All rights reserved.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var listTitle: String?
    @NSManaged public var listDesc: String?
    @NSManaged public var listID: UUID?
    @NSManaged public var itemsInList: Item?

}
