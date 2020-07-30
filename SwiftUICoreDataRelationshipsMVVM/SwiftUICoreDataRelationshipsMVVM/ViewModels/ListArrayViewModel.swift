
//
//  ListArrayViewModel.swift
//  SwiftUICoreDataRelationshipsMVVM
//
//  Created by Anton Standwerth on 2020-07-30.
//  Copyright © 2020 Standwerth. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class ListArrayViewModel: ObservableObject {
    
    @Published var lists = [ListViewModel]()
    
    init() {
        getAllLists()
    }
    
    func getAllLists() {
        self.lists = CoreDataManager.shared.fetchAllLists().map(ListViewModel.init)
    }
    
    func fetchList(listVM: ListViewModel) -> List? {
        CoreDataManager.shared.fetchList(listTitle: listVM.listTitle)
    }
    
    func deleteList(listVM: ListViewModel) {
        CoreDataManager.shared.deleteList(listTitle: listVM.listTitle)
    }
    
}

class ListViewModel: ObservableObject {
    var listTitle = ""
    var listDesc = ""
    var listID = UUID()
    
    init(list: List) {
        self.listTitle = list.listTitle ?? "Unknown title"
        self.listDesc = list.listDesc ?? "Unknown description"
    }
    
}
