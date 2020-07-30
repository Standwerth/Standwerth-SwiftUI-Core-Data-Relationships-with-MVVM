//
//  CoreDataManager.swift
//  SwiftUICoreDataRelationshipsMVVM
//
//  Created by Anton Standwerth on 2020-07-30.
//  Copyright © 2020 Standwerth. All rights reserved.
//

import Foundation
import CoreData
import Combine
import SwiftUI

class CoreDataManager {
    
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: - Item C.R.U.D
    
    func saveItem(itemTitle: String, itemDesc: String) {
        
        let item = Item(context: self.moc)
        item.itemTitle   = itemTitle
        item.itemDesc   = itemDesc
        item.itemID     = UUID()
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print("Added item")
    }
    
    func deleteItem(itemTitle: String){
        do {
            if let item = fetchItem(itemTitle: itemTitle){
                self.moc.delete(item)
                try self.moc.save()
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func fetchAllItems() -> [Item] {
        var items = [Item]()
        
        let itemsRequest : NSFetchRequest<Item>  = Item.fetchRequest()
        
        do {
            items = try self.moc.fetch(itemsRequest)
        } catch let error as NSError {
            print(error)
        }
        
        return items
    }
    
    func fetchItem(itemTitle:String) -> Item? {
        var items    = [Item]()
        
        let request: NSFetchRequest<Item>    = Item.fetchRequest()
        request.predicate    = NSPredicate(format: "itemTitle == %@", itemTitle)
        
        do {
            items = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        
        return items.first
    }
    
    // MARK: - List C.R.U.D
    
    func saveList(listTitle: String, listDesc: String) {
        let list = List(context: moc)
        
        list.listTitle = listTitle
        list.listDesc = listDesc
        list.listID = UUID()
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func deleteList(listTitle: String){
        do {
            if let list = fetchList(listTitle: listTitle){
                self.moc.delete(list)
                try self.moc.save()
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func fetchAllLists() -> [List] {
        var lists = [List]()
        
        let listsRequest : NSFetchRequest<List>  = List.fetchRequest()
        
        do {
            lists = try self.moc.fetch(listsRequest)
        } catch let error as NSError {
            print(error)
        }
        
        return lists
    }
    
    func fetchList(listTitle: String) -> List? {
        var lists    = [List]()
        
        let request: NSFetchRequest<List>    = List.fetchRequest()
        request.predicate    = NSPredicate(format: "listTitle == %@", listTitle)
        
        do {
            lists = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        
        return lists.first
    }
    
}


