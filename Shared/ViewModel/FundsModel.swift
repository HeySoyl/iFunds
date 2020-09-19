//
//  FundsModel.swift
//  iFunds (iOS)
//
//  Created by 刘志启 on 2020/9/19.
//

import SwiftUI
import CoreData
import Combine

class FundsModel : ObservableObject {
    @Published var funds : [NSManagedObject] = []
    @Published var fundsCode = ""
//    @Published var item = Item()
    let context = PersistenceController.shared.container.viewContext
    
    init() {
        readData()
    }
    
    func readData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        do {
            let results = try context.fetch(request)
            
            self.funds = results as! [NSManagedObject]
        } catch { print(error.localizedDescription) }
    }
    
    func writeData() {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context)
        
        entity.setValue(fundsCode, forKey: "fundsCode")
        
        do {
            try context.save()
            
            self.funds.append(entity)
        } catch { print(error.localizedDescription) }
    }
    func deleteData() {}
    func updateData() {}
    
    func getValue(obj : NSManagedObject) -> String {
        return obj.value(forKey: "fundsCode") as! String
    }
}
