//
//  TotalList.swift
//  yeogidam
//
//  Created by Kangwook Lee on 2022/11/20.
//

import SwiftUI

struct DistrictListView: View {
	let items: [District] = [.example1, .example2, .example3]
	init() {
		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = .ygdNavy
		appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		
		UINavigationBar.appearance().standardAppearance = appearance
		UINavigationBar.appearance().scrollEdgeAppearance = appearance
	}
	var body: some View {
		NavigationView {
			List {
				ForEach(items, id: \.items) { row in
					Text(row.name)
				}
				.listRowBackground(Color.white)
				
			}
			.listStyle(.plain)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text("전체 목록").font(.headline).foregroundColor(.white)
				}
			}
			.background(Color(uiColor: .white))
		}
		.preferredColorScheme(.dark)
		
		
	}
}

/*
 struct TotalList_Previews: PreviewProvider {
 static var previews: some View {
 TotalList()
 }
 }
 */
