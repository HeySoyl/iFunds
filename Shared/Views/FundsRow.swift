//
//  FundsRow.swift
//  iFunds
//
//  Created by 刘志启 on 2020/9/17.
//

import SwiftUI

struct FundsRow: View {
    @EnvironmentObject var model: Funds
    
    var body: some View {
        VStack {
            FundsRowList(fundsCode: model.fundsCode ?? "").environmentObject(model)
        }
    }
}

struct FundsRowList: View {
    @ObservedObject var fundModel: FundsApiService
    @EnvironmentObject var model: Funds

    init(fundsCode: String) {
        fundModel = FundsApiService(fundsCode: fundsCode)
    }

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    //基金名称
                    Text(fundModel.funds.name ?? "")
                    
                    //基金码
                    Text(model.fundsCode ?? "")
                        .font(.caption)
                }
                
                Spacer()
                
                //持有金额
                if Double(fundModel.funds.gsz ?? "0.0")! > model.positonCost {
                    Text(getPositonHeld(positonShare: model.positonShare , gsz: fundModel.funds.gsz ?? "0.0"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                } else if Double(fundModel.funds.gsz ?? "0.0")! < model.positonCost  {
                    Text(getPositonHeld(positonShare: model.positonShare , gsz: fundModel.funds.gsz ?? "0.0"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                } else {
                    Text(getPositonHeld(positonShare: model.positonShare , gsz: fundModel.funds.gsz ?? "0.0"))
                        .font(.title)
                        .fontWeight(.bold)
                        .font(.footnote)
                }
            }
            Spacer()
            HStack {
                VStack {
                    //今日盈利：单价 （gsz - dwjz）* 持仓数额（positonShare）， 为正则盈利，为负则亏损
                    Text("今日盈利")
                        .font(.footnote)
                    if Double(getTodayProfit(positonShare: model.positonShare , gsz: fundModel.funds.gsz ?? "0.0", dwjz: fundModel.funds.dwjz ?? "0.0"))! > 0.0 {
                        Text(getTodayProfit(positonShare: model.positonShare , gsz: fundModel.funds.gsz ?? "0.0", dwjz: fundModel.funds.dwjz ?? "0.0"))
                            .font(.footnote)
                            .foregroundColor(.red)
                    } else if Double(getTodayProfit(positonShare: model.positonShare , gsz: fundModel.funds.gsz ?? "0.0", dwjz: fundModel.funds.dwjz ?? "0.0"))! < 0.0 {
                        Text(getTodayProfit(positonShare: model.positonShare , gsz: fundModel.funds.gsz ?? "0.0", dwjz: fundModel.funds.dwjz ?? "0.0"))
                            .font(.footnote)
                            .foregroundColor(.green)
                    } else {
                        Text(getTodayProfit(positonShare: model.positonShare , gsz: fundModel.funds.gsz ?? "0.0", dwjz: fundModel.funds.dwjz ?? "0.0"))
                            .font(.footnote)
                    }
                }
                                
                Spacer()
                
                VStack {
                    //总盈利：单价 （gsz - positonCost）* 持仓数额（positonShare）， 为正则盈利，为负则亏损
                    Text("总盈利")
                        .font(.footnote)
                    if Double(getAllProfit(positonShare: model.positonShare , positonCost: model.positonCost , gsz: fundModel.funds.gsz ?? "0.0"))! > 0.0 {
                        Text(getAllProfit(positonShare: model.positonShare , positonCost: model.positonCost , gsz: fundModel.funds.gsz ?? "0.0"))
                            .font(.footnote)
                            .foregroundColor(.red)
                    } else if Double(getAllProfit(positonShare: model.positonShare , positonCost: model.positonCost , gsz: fundModel.funds.gsz ?? "0.0"))! < 0.0 {
                        Text(getAllProfit(positonShare: model.positonShare , positonCost: model.positonCost , gsz: fundModel.funds.gsz ?? "0.0"))
                            .font(.footnote)
                            .foregroundColor(.green)
                    } else {
                        Text(getAllProfit(positonShare: model.positonShare , positonCost: model.positonCost , gsz: fundModel.funds.gsz ?? "0.0"))
                            .font(.footnote)
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("日涨幅")
                        .font(.footnote)
                    //日涨幅
                    if Double(fundModel.funds.gszzl ?? "0.0")! > 0.0 {
                        Text("\(fundModel.funds.gszzl ?? "")%")
                            .font(.footnote)
                            .foregroundColor(.red)
                    } else if Double(fundModel.funds.gszzl ?? "0.0")! < 0.0 {
                        Text("\(fundModel.funds.gszzl ?? "")%")
                            .font(.footnote)
                            .foregroundColor(.green)
                    } else {
                        Text("\(fundModel.funds.gszzl ?? "")%")
                            .font(.footnote)
                    }
                }
            }
        }
    }
    
    //持有金额： 持仓数额（positonShare）* gsz(最新价格) ，gsz > 持仓成本（positonCost）则盈利
    func getPositonHeld(positonShare: Double!, gsz: String!) -> String {
        return String(format: "%.2f", positonShare * Double(gsz)!)
    }
    
    //今日盈利：单价 （gsz - dwjz）* 持仓数额（positonShare）， 为正则盈利，为负则亏损
    func getTodayProfit(positonShare: Double!, gsz: String!, dwjz: String!) -> String {
        return String(format: "%.2f", (Double(gsz)! - Double(dwjz)!) * positonShare)
    }
    
    //总盈利：单价 （gsz - positonCost）* 持仓数额（positonShare）， 为正则盈利，为负则亏损
    func getAllProfit(positonShare: Double!, positonCost: Double!, gsz: String!) -> String {
        return String(format: "%.2f", (Double(gsz)! - positonCost) * positonShare)
    }
}
