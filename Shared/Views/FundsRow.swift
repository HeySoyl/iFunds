//
//  FundsRow.swift
//  iFunds
//
//  Created by 刘志启 on 2020/9/17.
//

import SwiftUI

struct FundsRow: View {
    @EnvironmentObject var model: Item
    
    var body: some View {
        VStack {
            FundsRowList(fundsCode: model.fundsCode ?? "").environmentObject(model)
        }
    }
}

struct FundsRowList: View {
    @ObservedObject var fundModel: FundsApiService
    @EnvironmentObject var model: Item

    init(fundsCode: String) {
        fundModel = FundsApiService(fundsCode: fundsCode)
    }

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    //基金名称
                    Text(fundModel.funds.name ?? "")
                        .foregroundColor(.white)
                    
                    //基金码
                    Text(fundModel.funds.fundcode ?? "")
                        .font(.caption)
                }
                
                Spacer()
                
                //持有金额： 持仓数额（positonShare）* gsz(最新价格) ，gsz > 持仓成本（positonCost）则盈利
                Text(fundModel.funds.gsz ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top,10)
            }
            HStack {
                //今日盈利：单价 （gsz - dwjz）* 持仓数额（positonShare）， 为正则盈利，为负则亏损
                Text(fundModel.funds.gsz ?? "")
                    .foregroundColor(.white)
                    .padding(.top,10)
                
                Spacer()
                
                //今日盈利：单价 （gsz - dwjz）* 持仓数额（positonShare）， 为正则盈利，为负则亏损
                Text(fundModel.funds.gsz ?? "")
                    .foregroundColor(.white)
                    .padding(.top,10)
                
                Spacer()
                
                //日涨幅
                Text("\(fundModel.funds.gszzl ?? "")%")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color("energy"))
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        .cornerRadius(15)
    }
}
