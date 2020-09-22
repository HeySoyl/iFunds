//
//  FundsViewModel.swift
//  iFunds
//
//  Created by 刘志启 on 2020/9/21.
//

import SwiftUI
import Combine

class FundsViewModel: ObservableObject {
    @Published var dwjz: String = "" //昨日净值
    @Published var gsz: String = "" //今日净值
    @Published var gszzl: String = ""  //日涨幅
    @Published var posts = Item()
}
