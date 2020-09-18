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

    var body: some View {
        NavigationView {
            List {
                SearchBar(fundesCode: $fundesCode)
                
                ForEach(items) { item in
                    NavigationLink(destination: FundsInfo()) {
                        FundsRow()
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("基金列表")
        }
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
