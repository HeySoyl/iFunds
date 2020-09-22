//
//  NavigationInfoBar.swift
//  iFunds
//
//  Created by 刘志启 on 2020/9/21.
//

import SwiftUI

struct NavigationInfoBar: View {
    @ObservedObject var model = IndexApiService()
    
    // 上证指数、深证指数
    var body: some View {
        HStack {
            Spacer()
            VStack {
                model1
            }
            
            Spacer()
            
            VStack {
                model2
            }
            
            Spacer()
            
            VStack {
                model3
            }
            Spacer()
        }
    }
    
    // 上证指数
    var model1: some View {
        VStack {
            if model.posts.data?.diff?[0].f3 ?? 0 > 0.0 {
                Text("\(model.posts.data?.diff?[0].f2 ?? 0, specifier: "%g")")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red)
            } else if model.posts.data?.diff?[0].f3 ?? 0 < 0.0 {
                Text("\(model.posts.data?.diff?[0].f2 ?? 0, specifier: "%g")")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.green)
            } else {
                Text("\(model.posts.data?.diff?[0].f2 ?? 0, specifier: "%g")")
                    .font(.title3)
                    .bold()
            }
            HStack {
                Text("上证")
                    .font(.footnote)
                if model.posts.data?.diff?[0].f3 ?? 0 > 0.0 {
                    Text("\(model.posts.data?.diff?[0].f3 ?? 0, specifier: "%g")%")
                        .font(.footnote)
                        .foregroundColor(.red)
                } else if model.posts.data?.diff?[0].f3 ?? 0 < 0.0 {
                    Text("\(model.posts.data?.diff?[0].f3 ?? 0, specifier: "%g")%")
                        .font(.footnote)
                        .foregroundColor(.green)
                } else {
                    Text("\(model.posts.data?.diff?[0].f3 ?? 0, specifier: "%g")%")
                        .font(.footnote)
                }
            }
        }
    }
    
    // 深证指数
    var model2: some View {
        VStack {
            if model.posts.data?.diff?[1].f3 ?? 0 > 0.0 {
                Text("\(model.posts.data?.diff?[1].f2 ?? 0, specifier: "%g")")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red)
            } else if model.posts.data?.diff?[1].f3 ?? 0 < 0.0 {
                Text("\(model.posts.data?.diff?[1].f2 ?? 0, specifier: "%g")")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.green)
            } else {
                Text("\(model.posts.data?.diff?[1].f2 ?? 0, specifier: "%g")")
                    .font(.title3)
                    .bold()
            }
            HStack {
                Text("深证")
                    .font(.footnote)
                if model.posts.data?.diff?[1].f3 ?? 0 > 0.0 {
                    Text("\(model.posts.data?.diff?[1].f3 ?? 0, specifier: "%g")%")
                        .font(.footnote)
                        .foregroundColor(.red)
                } else if model.posts.data?.diff?[1].f3 ?? 0 < 0.0 {
                    Text("\(model.posts.data?.diff?[1].f3 ?? 0, specifier: "%g")%")
                        .font(.footnote)
                        .foregroundColor(.green)
                } else {
                    Text("\(model.posts.data?.diff?[1].f3 ?? 0, specifier: "%g")%")
                        .font(.footnote)
                }
            }
        }
    }
    
    // 创业扳指
    var model3: some View {
        VStack {
            if model.posts.data?.diff?[2].f3 ?? 0 > 0.0 {
                Text("\(model.posts.data?.diff?[2].f2 ?? 0, specifier: "%g")")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red)
            } else if model.posts.data?.diff?[2].f3 ?? 0 < 0.0 {
                Text("\(model.posts.data?.diff?[2].f2 ?? 0, specifier: "%g")")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.green)
            } else {
                Text("\(model.posts.data?.diff?[2].f2 ?? 0, specifier: "%g")")
                    .font(.title3)
                    .bold()
            }
            HStack {
                Text("创业扳")
                    .font(.footnote)
                if model.posts.data?.diff?[2].f3 ?? 0 > 0.0 {
                    Text("\(model.posts.data?.diff?[2].f3 ?? 0, specifier: "%g")%")
                        .font(.footnote)
                        .foregroundColor(.red)
                } else if model.posts.data?.diff?[2].f3 ?? 0 < 0.0 {
                    Text("\(model.posts.data?.diff?[2].f3 ?? 0, specifier: "%g")%")
                        .font(.footnote)
                        .foregroundColor(.green)
                } else {
                    Text("\(model.posts.data?.diff?[2].f3 ?? 0, specifier: "%g")%")
                        .font(.footnote)
                }
            }
        }
    }
}

struct NavigationInfoBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationInfoBar()
    }
}
