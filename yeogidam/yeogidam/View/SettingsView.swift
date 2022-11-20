//
//  Settings.swift
//  yeogidam
//
//  Created by Kangwook Lee on 2022/11/20.
//

import SwiftUI
struct Setting: Identifiable {
	var id = UUID()
	var name: String
}
struct SettingsView: View {
	let settings:[Setting] = [.init(name: "공지사항"), .init(name: "알림설정"), .init(name: "개발자 문의"), .init(name: "서비스 정보"), .init(name: "앱 버전")]
	init() {
		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = .ygdNavy
		appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		
		UINavigationBar.appearance().standardAppearance = appearance
		UINavigationBar.appearance().scrollEdgeAppearance = appearance
	}
    var body: some View {
		NavigationView {
			List(settings) { setting in
				NavigationLink {
					DetailSettingView(setting: setting)
				} label: {
					Text(setting.name)
				}
			}
			.listStyle(.plain)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text("환경 설정").font(.headline).foregroundColor(.white)
				}
			}
		}
    }
}


/*
struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
*/
