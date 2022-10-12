//
//  ContentView.swift
//  yeogidam
//
//  Created by Kangwook Lee on 2022/10/05.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

struct ContentView: View {
    var body: some View {
        Main()
    }
}

struct Main: View {
    
    @StateObject private var viewModel = MainViewModel()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $viewModel.region,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode
            )
            .ignoresSafeArea()
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    LocationButton(.currentLocation) {
                        
                    }
                    .cornerRadius(30)
                    .foregroundColor(Color.white)
                    .tint(.blue)
                    .symbolVariant(.fill)
                    .labelStyle(.iconOnly)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 30))
                    .opacity(0.8)
                }
            }
        }
    }
}

final class MainViewModel:NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager?.delegate = self
                self.locationManager = CLLocationManager()
                self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            } else {
                print("Please check GPS.")
            }
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Error : restricted")
        case .denied:
            print("Error : denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
