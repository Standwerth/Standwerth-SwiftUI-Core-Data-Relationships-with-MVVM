//
//  ItemArrayViewModel.swift
//  SwiftUICoreDataRelationshipsMVVM
//
//  Created by Anton Standwerth on 2020-07-30.
//  Copyright © 2020 Standwerth. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class ItemArrayViewModel: ObservableObject {
    
    @Published var items = [ItemViewModel]()
    
    init() {
        getAllItems()
    }
    
    func getAllItems() {
        self.items = CoreDataManager.shared.fetchAllItems().map(ItemViewModel.init)
    }
    
    func deleteItem(itemVM: ItemViewModel) {
        CoreDataManager.shared.deleteItem(itemTitle: itemVM.itemTitle)
        getAllItems()
    }
    
    func fetchItem(itemVM: ItemViewModel) -> Item? {
        CoreDataManager.shared.fetchItem(itemTitle: itemVM.itemTitle)
    }
    
}

class ItemViewModel: ObservableObject {
    var itemTitle = ""
    var itemDesc = ""
    var itemID = UUID()
    var createdAt = Date()
    
    init(item: Item) {
        self.itemTitle = item.itemTitle ?? "Unknown title"
        self.itemDesc = item.itemDesc ?? "Unknown description"
    }
    
}

