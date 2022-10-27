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
    @State private var selectedStation: Station? = nil
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.location,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: nil,
                annotationItems: viewModel.stations) { station in
                MapAnnotation(coordinate: station.location) {
                    StationBadgeView(station: station)
                        .onTapGesture {
                            selectedStation = station
                        }
                }
            }
        }
        .ignoresSafeArea()
        .sheet(item: $selectedStation) { station in
            StationView(viewModel: StationViewModel(station: station))
        }
    }
}

struct StationBadgeView: View {
    private let station: Station
    
    internal init(station: Station) {
        self.station = station
    }
    
    public var body: some View {
        VStack {
            Text(station.name)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            Circle()
                .stroke(Color.blue, lineWidth: 5)
                .frame(width: 30, height: 30)
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
