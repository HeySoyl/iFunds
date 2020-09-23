//
//  Home.swift
//  iFunds
//
//  Created by 刘志启 on 2020/9/20.
//


import SwiftUI
import CoreData

struct Home: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Funds.order, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Funds>

    @State private var fundesCode = ""
    @State private var isEditing = false    //搜索是否在编辑状态
    @State private var isEditable = false   //列表编辑状态
    
    var body: some View {
        VStack {
            NavigationInfoBar()
                .padding(.horizontal)

            searchBar

            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink(destination: FundsInfo().environmentObject(item)) {
                        FundsRow().environmentObject(item)
                    }
                }
                .onDelete(perform: deleteFunds)
                .onMove(perform: moveFunds)
//                .onLongPressGesture(minimumDuration: 0.5) {
//                    withAnimation {
//                        self.isEditable = true
//                    }
//                }
            }
//            .environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
        }
    }

    var searchBar: some View {
        HStack {
            TextField("搜索", text: $fundesCode)
                .padding(15)
                .padding(.horizontal, 25)
//                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 15.0)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                        if isEditing {
                            Button(action: {
                                self.fundesCode = ""
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

            Button(action: addFunds) {
//                Image(systemName: "plus")
//                    .foregroundColor(.gray)
                Text("保存")
            }

        }
        .padding(.vertical, 5.0)
        .padding(.horizontal, 15.0)
    }

    private func addFunds() {
        withAnimation {
            let newFunds = Funds(context: viewContext)
            self.isEditing = false
            newFunds.timestamp = Date()
            newFunds.order = (items.last?.order ?? 0) + 1
            newFunds.fundsCode = self.fundesCode
            saveData()
        }
    }

    private func deleteFunds(offsets: IndexSet) {
        withAnimation {
//            let source = offsets.first!
//            let listItem = items[source]
//            viewContext.delete(listItem)
            offsets.map { items[$0] }.forEach(viewContext.delete)
            saveData()
            
            self.isEditable = false
        }
    }
    
    private func moveFunds(from indexSet: IndexSet, to destination: Int) {
        withAnimation {
            let source = indexSet.first!

            if source < destination {
                var startIndex = source + 1
                let endIndex = destination - 1
                var startOrder = items[source].order
                while startIndex <= endIndex {
                    items[startIndex].order = startOrder
                    startOrder = startOrder + 1
                    startIndex = startIndex + 1
                }

                items[source].order = startOrder

            } else if destination < source {
                var startIndex = destination
                let endIndex = source - 1
                var startOrder = items[destination].order + 1
                let newOrder = items[destination].order
                while startIndex <= endIndex {
                    items[startIndex].order = startOrder
                    startOrder = startOrder + 1
                    startIndex = startIndex + 1
                }
                items[source].order = newOrder
            }
            saveData()
            
            self.isEditable = false
        }
    }
    
    func saveData() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
