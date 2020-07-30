//
//  AddListViewModel.swift
//  SwiftUICoreDataRelationshipsMVVM
//
//  Created by Anton Standwerth on 2020-07-30.
//  Copyright © 2020 Standwerth. All rights reserved.
//

import Foundation

class AddListViewModel {
    var listTitle = ""
    var listDesc = ""
    var listID = UUID()
    
    func addList() {
        CoreDataManager.shared.saveList(listTitle: self.listTitle, listDesc: self.listDesc)
    }
    
}
