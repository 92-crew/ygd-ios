//
//  MapView.swift
//  
//
//  Created by andy.swift on 2022/10/06.
//

import SwiftUI
import MapKit
import ViewModels

public struct MapView: View {
    @StateObject private var viewModel: MapViewModel = MapViewModel()
    
    public init() { }
    
    public var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.location,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: nil)
        }.ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
