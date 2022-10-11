//
//  MapViewModel.swift
//  
//
//  Created by andy.swift on 2022/10/12.
//

import Foundation
import MapKit

public final class MapViewModel: ObservableObject {
    @Published public var location: MKCoordinateRegion
    
    public init() {
        print("🚨")
        let location = CLLocationCoordinate2D(latitude: 37.5176577, longitude: 126.8842201)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        self.location = region
    }
}
