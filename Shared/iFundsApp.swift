//
//  iFundsApp.swift
//  Shared
//
//  Created by 刘志启 on 2020/9/16.
//

import SwiftUI

@main
struct iFundsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .frame(minWidth: 870, maxWidth: .infinity, minHeight: 650, maxHeight: .infinity)
        }
    }
}
