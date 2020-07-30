//
//  ListsView.swift
//  SwiftUICoreDataRelationshipsMVVM
//
//  Created by Anton Standwerth on 2020-07-30.
//  Copyright © 2020 Standwerth. All rights reserved.
//

import SwiftUI

struct ListsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var listVM = ListArrayViewModel()
    @State var editList = false
    @State var showAddList = false
    @Binding var showLists: Bool
    
    var body: some View {
        ZStack {
            
            Color.green.edgesIgnoringSafeArea([.bottom, .horizontal])
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.black)
                        
                    }
                    
                    Text("Lists")
                        .font(.system(size: 30))
                        .bold()
                    
                    Spacer()
                    
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation{
                                
                                self.showAddList.toggle()
                                
                            }
                            
                        }) {
                            Image(systemName: "text.badge.plus").resizable().frame(width: 12, height: 12)
                            Text("Add List")
                        }.foregroundColor(Color.white)
                        
                        
                    }.padding().padding(.vertical, -10).background(Color.black)
                    
                    Button(action: {
                        self.editList.toggle()
                    }) {
                        Text(self.editList ? "Done" : "Edit").font(.headline).foregroundColor(Color.black)
                    }
                }
                    
                .padding()
                .background(Color.white)
                
                VStack {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack {
                            
                            ForEach(self.listVM.lists, id: \.listTitle) { list in
                                
                                HStack {
                                    
                                    if self.editList {
                                        
                                        Button(action: {
                                            self.listVM.deleteList(listVM: list)
                                            self.listVM.getAllLists()
                                        }) {
                                            
                                            Image(systemName: "minus.circle")
                                                .font(.title)
                                            
                                            
                                        }.foregroundColor(.red)
                                        
                                    }
                                    
                                    Text(list.listTitle)
                                        .foregroundColor(Color.black
                                    )
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                }.animation(.spring())
                                    .padding()
                                    .background(Color.white)
                                    .padding(.horizontal, 20)
                                    
                                    .onTapGesture {
                                        // The iddea is that when you tap on the List, it will load all of the Items associated with it in another ForEach stack inside the ContentView.swift file
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if self.showAddList {
                
                GeometryReader {_ in
                    
                    VStack {
                        
                        AddListView(showAddList: self.$showAddList)
                            .padding(.horizontal, 20)
                    }
                }
                .transition(.move(edge: .bottom))
                .background(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                .onDisappear() {
                    self.listVM.getAllLists()
                }
                
            }
        }
    }
}
struct AddListView: View {
    @State var addListVM = AddListViewModel()
    @State var showEmptyListTitle = false
    @Binding var showAddList: Bool
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                VStack {
                    
                    HStack {
                        
                        Text("What list name do you want?").font(.headline)
                        
                        Spacer()
                        
                        HStack {
                            
                            Button(action: {
                                
                                withAnimation{
                                    
                                    self.showAddList.toggle()
                                    
                                }
                                
                            }) {
                                
                                Image(systemName: "multiply.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                            }
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .clipShape(Circle())
                            
                        }
                        
                    }
                    
                    TextField("Example: What to do tomorrow", text: self.$addListVM.listTitle)
                        .padding()
                        .background(Color.white)
                    
                    
                }
                .padding([.horizontal, .top], 15)
                
                VStack {
                    
                    HStack {
                        
                        Text("Additional information")
                            .font(.headline)
                        
                        Spacer()
                        
                    }
                    
                    TextField("Summary / extra info (optional)", text: self.$addListVM.listDesc)
                        .padding()
                        .background(Color.white)
                        
                    
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 50)
                
            }
            .background(AddListRounded()
            .fill(Color.green))
            
            HStack {
                
                Button(action: {
                    
                    if self.addListVM.listTitle.isEmpty {
                        self.showEmptyListTitle.toggle()
                    }else {
                        self.addListVM.addList()
                        self.showAddList.toggle()
                    }
                    
                }) {
                    
                    Text("Add list")
                        .foregroundColor(Color.white)
                        .font(.headline)
                    
                }
                
            }
            .padding()
            .background(Color.black)
            
            .offset(y: 120)
                
            .alert(isPresented: $showEmptyListTitle) {
                Alert(title: Text("Attention"), message: Text("Please enter something"), dismissButton: .default(Text("Got it!")))
            }
            
        }
    }
}


struct AddListRounded : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight, .bottomRight, .topLeft, .bottomLeft], cornerRadii: CGSize(width: 25, height: 25))
        
        return Path(path.cgPath)
    }
}
