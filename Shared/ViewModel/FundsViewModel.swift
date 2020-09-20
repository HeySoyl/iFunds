//
//  FundsViewModel.swift
//  iFunds (iOS)
//
//  Created by 刘志启 on 2020/9/19.
//

import SwiftUI
import CoreData
import Combine

class FundsViewModel : ObservableObject {
    @Published var funds: [NSManagedObject] = []
//    @Published var fundsInfo: [Item] = []
    @Published var fundsInfo = [FundsModel]()

    @Published var fundsCode = ""
    //updateData
    @Published var isUpddate = false
    @Published var positonCost = ""
    @Published var positonShare = ""
    
    // FIXME: 这里有个Error需要处理init()函数
    @Published var selectedObj: NSManagedObject = NSManagedObject()
        
    let context = PersistenceController.shared.container.viewContext
    
    init() {
        readData()
    }
    
//    func readData() {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
//
//        do {
//            let results = try context.fetch(request)
//
//            self.funds = results as! [NSManagedObject]
//        } catch { print(error.localizedDescription) }
//    }
    
    func readData() {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            
//            self.funds = results as! [NSManagedObject]
            self.fundsInfo = results.map {
                FundsModel.init(entry: $0)
            }
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
    
    func deleteData(indexSet: IndexSet) {
        for index in indexSet {
            do {
                let obj = funds[index]
                
                context.delete(obj)
                
                try context.save()
                
                let index = funds.firstIndex(of: obj)
                
                funds.remove(at: index!)
                
            } catch { print(error.localizedDescription) }
        }
    }
    
    func updateData() {
        let index = funds.firstIndex(of: selectedObj)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            let obj = results.first { (obj) -> Bool in
                if obj == selectedObj {return true}
                else {return false}
            }
            
            obj?.setValue(positonCost, forKey: "positonCost")
            obj?.setValue(positonShare, forKey: "positonShare")
            
            try context.save()
            
            funds[index!] = obj!
            isUpddate.toggle()
            positonCost = ""
            positonShare = ""
            
        } catch { print(error.localizedDescription) }
    }
    
    func getValue(obj : NSManagedObject) -> String {
        return obj.value(forKey: "fundsCode") as! String
    }

    
    func openUpdateView(obj: NSManagedObject) {
        selectedObj = obj
        isUpddate.toggle()
    }
}


class FundsModel {

    var fundsCode: String
    var positonCost: String
    var positonShare: String

    init(entry: Item) {
        fundsCode = entry.fundsCode ?? "Not working"
        positonCost = entry.positonCost ?? "Not working"
        positonShare = entry.positonShare ?? "Not working"
    }
}
