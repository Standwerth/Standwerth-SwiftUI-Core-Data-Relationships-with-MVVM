//
//  ContentView.swift
//  SwiftUICoreDataRelationshipsMVVM
//
//  Created by Anton Standwerth on 2020-07-30.
//  Copyright © 2020 Standwerth. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var listVM: ListArrayViewModel
    @ObservedObject var itemVM: ItemArrayViewModel
    @State var showAdd = false
    @State var showLists = false
    
    init() {
        self.listVM = ListArrayViewModel()
        self.itemVM = ItemArrayViewModel()
    }
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea([.bottom, .horizontal])
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        self.showAdd.toggle()
                    }) {
                        HStack {
                            
                            Spacer()
                            
                            Image(systemName: "plus.square.fill").resizable().frame(width: 10, height: 10)
                            Text("Add Item").font(.headline)
                            
                            Spacer()
                        }.padding().background(Color.white).foregroundColor(Color.black)
                    }
                }
                    
                .sheet(isPresented: self.$showAdd, onDismiss: {
                    
                },content: {
                    AddItemView(showAdd: self.$showAdd)
                })
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        self.showLists.toggle()
                    }) {
                        HStack {
                            
                            Spacer()
                            
                            Image(systemName: "doc.plaintext").resizable().frame(width: 10, height: 13)
                            Text("Lists").font(.headline)
                            
                            Spacer()
                        }.padding().background(Color.white).foregroundColor(Color.black)
                    }
                }
                
                .sheet(isPresented: self.$showLists, onDismiss: {
                    
                },content: {
                    ListsView(showLists: self.$showLists)
                })
                
            }
        }
    }
}


