//
//  SearchBar.swift
//  yeogidam
//
//  Created by 이강욱 on 2022/10/27.
//

import SwiftUI

struct SearchBar: View {
    let stations = [ "구의역", "건대입구역", "강변역", "잠실나루역", "잠실역",
                     "잠실새내역", "종합운동장역", "삼성역", "선릉역", "역삼역",
                     "강남역", "교대역", "남부터미널역", "양재역"]
    @Binding var text: String
    @State var editText: Bool = false
    var body: some View {
        TextField("Search", text: $text)
            .padding(15)
			.background(.white)
            .cornerRadius(15)
            .overlay(
                HStack{
                    Spacer()
                    if self.editText {
                        Button(action: {
                            self.editText = false
                            self.text = ""
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }, label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(Color(.black))
                                .padding()
                        })
                    } else {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(.black))
                            .padding()
                    }
                }
            ).onTapGesture {
                self.editText = true
            }
        
    }
}

