//
//  SearchBar.swift
//  iFunds
//
//  Created by 刘志启 on 2020/9/16.
//

import SwiftUI

struct SearchBar: View {
    @Binding var fundesCode: String
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            HStack {
                TextField("搜索", text: $fundesCode)
                    .padding(15)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 15.0)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            if isEditing {
                                Button(action: {
                                    self.fundesCode = ""
                                    self.isEditing = false
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                }
                                .padding(.trailing, 5.0)
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    )
                    .onTapGesture {
                        self.isEditing = true
                    }
            }
            .padding(.horizontal, 15.0)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(fundesCode: .constant(""))
    }
}
