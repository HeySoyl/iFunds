//
//  FundsInfo.swift
//  iFunds
//
//  Created by 刘志启 on 2020/9/17.
//

import SwiftUI

struct FundsInfo: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var model: Funds
    
    @State private var positonCost = ""
    @State private var positonShare = ""
            
    var body: some View {
        VStack{
            Section(header: Text(model.fundsCode ?? "")) {
                HStack {
                    TextField("持仓数额", text: self.$positonShare)
                        .keyboardType(.numberPad)
                }
                
                TextField("持仓单价", text: self.$positonCost)
                    .keyboardType(.numberPad)
                
                Button(action: addItem) {
                    Text("保存")
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            self.model.positonCost = Double(self.positonCost) ?? 0.0
            self.model.positonShare = Double(self.positonShare) ?? 0.0
            self.model.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//struct FundsInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        FundsInfo()
//    }
//}
