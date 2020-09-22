//
//  ApiService.swift
//  iFunds (iOS)
//
//  Created by 刘志启 on 2020/9/19.
//

import SwiftUI
import Alamofire
import Combine

// MARK: -- ViewModel
//三证查询
final class IndexApiService: ObservableObject {
    init() {
        fetchPosts()
    }
    
    @Published var posts = Welcome()
    private func fetchPosts() {
        NetHandler().getIndexInfo {
            self.posts = $0
        }
    }
    
    let didChange = PassthroughSubject<IndexApiService, Never>()
    
}

//基金信息查询
final class FundsApiService: ObservableObject {
//    @Published var fundsCode = "320007"
    
    init(fundsCode: String) {
        fetchFunds(fundsCode: fundsCode)
    }
    
    @Published var funds = Fundgz()
    private func fetchFunds(fundsCode: String) {
        NetHandler().getFundsInfo(fundCode: fundsCode) {
            self.funds = $0
        }
    }
    
    let didChange = PassthroughSubject<FundsApiService, Never>()
    
}

// MARK: -- API
class NetHandler {
    
    // 指数提示
    func getIndexInfo(completion: @escaping (Welcome) -> Void ){
        //详细代码列表http://quote.eastmoney.com/center/hszs.html
        let url = "https://push2.eastmoney.com/api/qt/ulist.np/get?fltt=2&fields=f2,f3,f4,f12,f14&secids=1.000001,0.399001,0.399006"
        AF.request(url).responseJSON {response in
            guard let data = response.data else {return}
            do{
                guard let posts = try? JSONDecoder().decode(Welcome.self, from: data) else {return}
                completion(posts)
            }
       }
    }
    
    // 基金查询
    func getFundsInfo(fundCode: String, completion: @escaping (Fundgz) -> Void){
        let headers: HTTPHeaders = [
            "Content-Type":"application/x-www-form-urlencoded; charset=utf-8",
            "Accept":"application/json",
        ]
        let url = "http://fundgz.1234567.com.cn/js/\(fundCode).js"
        AF.request(url, headers: headers)
            .responseString(encoding: String.Encoding.utf8) { response in
                let data = response.value?
                .replacingOccurrences(of: "jsonpgz(", with: "")
                .replacingOccurrences(of: ");", with: "")
            
                let dic = data?.data(using: String.Encoding.utf8)
            
            do{
                guard let posts = try? JSONDecoder().decode(Fundgz.self, from: dic ?? Data()) else {return}
                completion(posts)
            }
        }
    }

}

// MARK: -- Model
struct Welcome: Codable {
    
    var rc, rt, svr, lt: Int?
    var full: Int?
    var data: DataClass?
    
    struct DataClass: Codable {
        var total: Int?
        var diff: [Diff]?

        struct Diff: Codable {
            var f2, f3, f4: Double?
            var f12, f14: String?
        }

    }
}

// MARK: - Fundgz
struct Fundgz: Codable {
    var fundcode: String?   //基金码
    var name: String?   //基金名称
    var jzrq: String?   //上一交易日日期
    var dwjz: String?   //昨日净值
    var gsz: String?    //今日净值
    var gszzl: String?  //日涨幅
    var gztime: String? //当前交易日时间
}
