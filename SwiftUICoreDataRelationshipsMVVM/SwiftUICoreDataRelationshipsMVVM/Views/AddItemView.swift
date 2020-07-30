//
//  AddItemView.swift
//  SwiftUICoreDataRelationshipsMVVM
//
//  Created by Anton Standwerth on 2020-07-30.
//  Copyright © 2020 Standwerth. All rights reserved.
//

import SwiftUI

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var addItemVM = AddItemViewModel()
    @ObservedObject var listVM = ListArrayViewModel()
    @State var showWarningAlert = false
    @State var isListSelected = false
    @State var selectionName = ""
    @Binding var showAdd: Bool
    
    
    var body: some View {
        ZStack {
            
            Color.green.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                
                VStack {
                    
                    HStack {
                        
                        Button(action: {
                            
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.black)
                            
                        }
                        
                        Text("New Item")
                            .font(.system(size: 30))
                            .bold()
                        
                        Spacer()
                        
                    }
                    .padding([.leading, .vertical], 15)
                    .background(Color.white)
                    
                    HStack {
                        
                        TextField("Title name", text: self.$addItemVM.itemTitle)
                            .lineLimit(1)
                            .foregroundColor(Color.black)
                        
                    }
                    .padding()
                    .background(Color.white)
                    .padding(.horizontal, 20)
                    
                    VStack {
                        
                        HStack {
                            
                            TextField("Write any additional information here.", text: self.$addItemVM.itemDesc)
                                .lineLimit(3)
                                .foregroundColor(Color.black)
                            
                        }
                        
                    }.padding().background(Color.white).padding(.horizontal, 20)
                    
                    VStack{
                        
                        ListPopUpView(selectionName: self.$selectionName, isListSelected: self.$isListSelected)
                        
                    }
                    
                    Spacer()
                    
                }
                
                VStack {
                    
                    VStack {
                        
                        Button("Add Item") {
                            
                            if self.addItemVM.itemTitle.isEmpty && self.isListSelected || self.addItemVM.itemTitle.isEmpty && self.isListSelected == false || self.addItemVM.itemTitle.isEmpty == false && self.isListSelected == false {
                                self.showWarningAlert.toggle()
                            }
                            
                            else {
                                self.addItemVM.listTitle = self.selectionName
                                self.addItemVM.addItem()
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            
                        }
                        .padding()
                        .foregroundColor(Color.black)
                        .font(.headline)
                        
                    }.background(Color.white).padding()
                }
                    
                .alert(isPresented: $showWarningAlert) {
                    Alert(title: Text("Attention"), message: Text("Please make sure you entered a title name as well as chose a list for the item to be added to"), dismissButton: .default(Text("Got it!")))
                }
                
            }
        }
    }
}

struct ListPopUpView: View {
    @ObservedObject var listVM = ListArrayViewModel()
    @State var expand = false
    @Binding var selectionName: String
    @Binding var isListSelected: Bool

    var body: some View {
        
        ZStack {
            
            VStack {
                
                HStack {
                    Button(action: {
                        
                        withAnimation {
                            
                        self.expand.toggle()
                            
                        }
                        
                    }) {
                        
                    Text("\(selectionName)")
                        .font(.headline)
                        
                    Image(systemName: "chevron.up")
                        .resizable()
                        .frame(width: 10, height: 7)
                        .rotationEffect(.degrees(expand ? 180 : 0))
                        .scaleEffect(expand ? 1.5 : 1)
                    }
                    
                }
                .foregroundColor(Color.black)
                .frame(width: 270, height: 40)
                .background(Color.white)
                    
                .onAppear() {
                    
                    self.selectionName = "Select a list"
                    
                }
                
                if expand {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack{
                            
                            ForEach(self.listVM.lists, id: \.listID) { list in
                                
                                VStack {
                                    
                                    Text(list.listTitle)
                                        .font(.system(size: 12))
                                        .bold()
                                        .foregroundColor(Color.black)
                                    
                                }
                                .frame(height: 8)
                                .padding()
                                .background(Color.green)
                                .padding(.vertical, 5)
                                    
                                .onTapGesture {
                                   
                                    if self.selectionName == "Select a list" {
                                        self.isListSelected = false
                                    } else {
                                        self.isListSelected = true
                                    }
                                    
                                     withAnimation {
                                    self.selectionName = list.listTitle
                                    self.expand.toggle()
                                    }
                                    
                                }.transition(.move(edge: .top))
                                
                            }
                            
                        }
                        
                    }
                    .frame(width: 270, height: 100)
                    .background(Color.white)
                    
                }
                
            }
            
            if expand {
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 270 , height:20)
                    .offset(y: -30)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 30 , height: 30)
                    .offset(x: 120, y: -40)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 30 , height: 30)
                    .offset(x: -120, y: -40)
                   
            }
        }
    }
}

