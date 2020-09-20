//
//  ContentView.swift
//  Shared
//
//  Created by 刘志启 on 2020/9/16.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var fundesCode = ""
    @State private var isEditing = false    //是否在编辑状态
    
    @StateObject var fundsModel = FundsModel()

//    var body: some View {
//        NavigationView {
//            VStack {
//
//                SearchBar(fundesCode: $fundesCode)
//
//                List {
//                    ForEach(items) { item in
//                        NavigationLink(destination: FundsInfo()) {
//                            FundsRow()
//                        }
//                    }
//                    .onDelete(perform: deleteItems)
//                }
//            }
//            .navigationTitle("基金")
//            .toolbar {
//                #if os(iOS)
//                EditButton()
//                #endif
//
//                Button(action: addItem) {
//                    Image(systemName: "plus")
//                        .foregroundColor(.gray)
//                }
//            }
//        }
//    }
    
    var body: some View {
//        NavigationView {
            VStack {
                ZStack {
                    HStack {
                        TextField("搜索", text: $fundsModel.fundsCode)
        //                TextField("搜索", text: $fundesCode)
                            .padding(15)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 15.0)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                                    if isEditing {
                                        Button(action: {
                                            self.fundsModel.fundsCode = ""
                                            self.isEditing = false
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                        }
                                        .padding(.trailing, 5.0)
                                        .buttonStyle(BorderlessButtonStyle())
                                    }
                                }
                            )
                            .onTapGesture {
                                self.isEditing = true
                            }

                        Button(action: fundsModel.writeData) {
                            Text("Save")
                        }

                    }
                    .padding(.horizontal, 15.0)
                }
                
                List {
                    ForEach(fundsModel.funds, id: \.objectID) { obj in
                        Text(fundsModel.getValue(obj: obj))
                            .onTapGesture{fundsModel.openUpdateView(obj: obj)}

                    }.onDelete(perform: fundsModel.deleteData(indexSet: ))
                }
                
//                List {
//                    ForEach(fundsModel.funds, id: \.self) { obj in
//                        NavigationLink(destination: FundsInfo(model: obj)) {
//                            FundsRow()
//                        }
//                    }.onDelete(perform: fundsModel.deleteData(indexSet: ))
//                }
                
            }
            .sheet(isPresented: $fundsModel.isUpddate) {
                FundsInfo(model: fundsModel)
            }
//        }
    }
    

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            self.isEditing = false
            newItem.timestamp = Date()
            newItem.fundsCode = self.fundesCode

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
