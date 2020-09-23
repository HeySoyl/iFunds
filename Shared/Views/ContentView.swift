//
//  ContentView.swift
//  Shared
//
//  Created by 刘志启 on 2020/9/16.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            #if os(macOS)
            Home()
            #endif
            
            #if os(iOS)
            Home()
                .navigationBarHidden(true)
            #endif
        }
//        .preferredColorScheme(.dark)
//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
