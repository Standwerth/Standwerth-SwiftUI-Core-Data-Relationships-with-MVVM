//
//  AddItemViewModel.swift
//  SwiftUICoreDataRelationshipsMVVM
//
//  Created by Anton Standwerth on 2020-07-30.
//  Copyright © 2020 Standwerth. All rights reserved.
//

import Foundation

class AddItemViewModel: ObservableObject {
    var itemTitle: String = ""
    var itemDesc: String = ""
    var itemID = UUID()
    var listTitle = ""
    
    func addItem() {
        CoreDataManager.shared.saveItem(itemTitle: self.itemTitle, itemDesc: self.itemDesc)
    }
    
}

