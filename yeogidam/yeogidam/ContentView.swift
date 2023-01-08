//
//  ContentView.swift
//  yeogidam
//
//  Created by Kangwook Lee on 2022/10/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
