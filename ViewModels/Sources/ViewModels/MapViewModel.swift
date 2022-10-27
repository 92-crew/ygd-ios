//
//  MapViewModel.swift
//  
//
//  Created by andy.swift on 2022/10/12.
//

import Foundation
import MapKit

public struct Station: Identifiable {
    public var id = UUID()
    public let name: String
    public let location: CLLocationCoordinate2D
}

public extension Station {
    static func dummy() -> Station {
        return Station(name: "dummy_station", location: CLLocationCoordinate2D(latitude: 37.5176577, longitude: 126.8842201))
    }
}

public final class MapViewModel: ObservableObject {
    @Published public var location: MKCoordinateRegion
    @Published public var stations: [Station] = []
    
    public init() {
        let location = CLLocationCoordinate2D(latitude: 37.5176577, longitude: 126.8842201)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        self.location = region
        
        self.loadStations()
    }
    
    public func loadStations() {
        self.stations = [
            Station(name: "이강욱", location: .init(latitude: 37.5165480, longitude: 126.8852199)),
            Station(name: "김현아", location: .init(latitude: 37.5176579, longitude: 126.8842210)),
            Station(name: "강지현", location: .init(latitude: 37.5186570, longitude: 126.8832190))
        ]
    }
}
