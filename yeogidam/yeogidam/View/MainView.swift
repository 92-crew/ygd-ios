//
//  Main.swift
//  yeogidam
//
//  Created by 이강욱 on 2022/10/27.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

struct Marker: Identifiable {
	let id = UUID()
	var coordinate: CLLocationCoordinate2D
	var isSelected: Bool
}
struct MainView: View {
	@StateObject private var viewModel = MainViewModel()
	@State private var userTrackingMode: MapUserTrackingMode = .follow
	@State var text = ""
	@State var selection = 2
	@State var favorite = false
	@State var select = false
	// MARK: 임시 마커
	let markers: [Marker] = [
		Marker(coordinate: CLLocationCoordinate2D(latitude: 37.53714369999987, longitude: 127.07777907903419), isSelected: false),
		Marker(coordinate: CLLocationCoordinate2D(latitude: 37.539453399999736, longitude: 127.08514809999947), isSelected: false),
		Marker(coordinate: CLLocationCoordinate2D(latitude: 37.53785229999968, longitude: 127.08550539999983), isSelected: false)
    ]
	
	var body: some View {
		TabView(selection: $selection) {
			DistrictListView()
				.tabItem {
					Image(uiImage: UIImage(named: "tabicon.list") ?? UIImage())
						.renderingMode(.template)
					Text("전체")
				}
				.tag(1)
			ZStack {
				Map(
					coordinateRegion: $viewModel.region,
					interactionModes: MapInteractionModes.all,
					showsUserLocation: true,
					userTrackingMode: $userTrackingMode,
					annotationItems: markers) { marker in
						MapAnnotation(coordinate: marker.coordinate) {
							Image(uiImage: UIImage(named: "marker.unselected") ?? UIImage())
						}
					}
					.edgesIgnoringSafeArea(.all)
				
				VStack {
					SearchBar(text: $text)
						.padding(EdgeInsets(top: 50	, leading: 10, bottom: 0, trailing: 10))
					Spacer()
					VStack {
						HStack {
							Spacer()
							Button(action: {
								if favorite {
									favorite = false
								} else {
									favorite = true
								}
							}, label: {
								if favorite {
									Image("button.favorite.enable")
								} else {
									Image("button.favorite.disable")
								}
							})
								.cornerRadius(30)
								.foregroundColor(Color.white)
								.tint(.blue)
								.symbolVariant(.fill)
								.labelStyle(.iconOnly)
								.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
						}
						HStack {
							Spacer()
							Button(action: {
								let locationManager = viewModel.locationManager
								viewModel.checkIfLocationServicesIsEnabled()
								locationManager!.requestLocation()
							}, label: {
								Image("button.current_location")
							})
								.cornerRadius(30)
								.foregroundColor(Color.white)
								.tint(.blue)
								.symbolVariant(.fill)
								.labelStyle(.iconOnly)
								.padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 10))
						}
					}
					.padding()
				}
			}
			.tabItem{
				Image(uiImage: UIImage(named: "tabicon.main") ?? UIImage())
					.renderingMode(.template)
				Text("흡연구역")
			}
			.ignoresSafeArea()
			.onAppear {
				viewModel.checkIfLocationServicesIsEnabled()
			}
			.tag(2)
			SettingsView()
			
				.tabItem {
					Image(uiImage: UIImage(named: "tabicon.settings") ?? UIImage())
						.renderingMode(.template)
					Text("설정")
				}
				.tag(3)
		}
		.accentColor(Color(uiColor: .ygdNavy))
		.onAppear {
			UITabBar.appearance().backgroundColor = .white
		}
	}
}

final class MainViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
	var locationManager: CLLocationManager?
	@Published var location: CLLocationCoordinate2D?
	@Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
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
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		
		DispatchQueue.main.async {
			self.location = location.coordinate
			self.region = MKCoordinateRegion(
				center: location.coordinate,
				span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
			)
		}
	}
}
