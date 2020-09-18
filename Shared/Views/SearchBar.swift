//
//  SearchBar.swift
//  iFunds
//
//  Created by 刘志启 on 2020/9/16.
//

import SwiftUI

struct SearchBar: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var fundesCode: String
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("搜索基金码", text: $fundesCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 5.0)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        if isEditing {
                            Button(action: { self.fundesCode = "" }) {
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
                        
            Button(action: addItem) {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
            }

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
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(fundesCode: .constant(""))
    }
}
