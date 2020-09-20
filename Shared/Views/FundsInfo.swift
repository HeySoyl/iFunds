//
//  FundsInfo.swift
//  iFunds
//
//  Created by 刘志启 on 2020/9/17.
//

import SwiftUI

struct FundsInfo: View {
    @ObservedObject var model: FundsViewModel
        
    var body: some View {
        VStack{
            HStack {
                TextField("持仓数额", text: $model.positonCost)
            }
            
            TextField("持仓单价", text: $model.positonShare)
            
            Button(action: model.updateData) {
                Text("保存")
            }
        }
    }
}

//struct FundsInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        FundsInfo()
//    }
//}
