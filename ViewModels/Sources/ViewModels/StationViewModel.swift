//
//  StationViewModel.swift
//  
//
//  Created by andy.swift on 2022/10/27.
//

import Foundation

public final class StationViewModel: ObservableObject {
    let station: Station
    
    public init(station: Station) {
        self.station = station
    }
    
    public var title: String {
        return self.station.name
    }
}
