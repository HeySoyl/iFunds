//
//  FundsRow.swift
//  iFunds
//
//  Created by 刘志启 on 2020/9/17.
//

import SwiftUI

struct FundsRow: View {
    var body: some View {
        VStack{
            HStack {
                Text("002218.SZ")
                Spacer()
                Text("4.180")
            }
            HStack {
                Text("拓日新能")
                    .font(.caption)
                Spacer()
                Text("+0.04")
                    .foregroundColor(.red)
            }
        }
    }
}

struct FundsRow_Previews: PreviewProvider {
    static var previews: some View {
        FundsRow()
    }
}
