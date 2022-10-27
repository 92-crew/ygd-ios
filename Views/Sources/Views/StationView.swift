//
//  StationView.swift
//  
//
//  Created by andy.swift on 2022/10/27.
//

import SwiftUI
import ViewModels

struct StationView: View {
    let viewModel: StationViewModel
    var body: some View {
        ZStack {
            Text(viewModel.title)
        }
    }
}

struct StationView_Previews: PreviewProvider {
    static var previews: some View {
        StationView(
            viewModel: StationViewModel(
                station: Station.dummy()
            )
        )
    }
}
