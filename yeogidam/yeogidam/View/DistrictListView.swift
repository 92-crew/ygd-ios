//
//  TotalList.swift
//  yeogidam
//
//  Created by Kangwook Lee on 2022/11/20.
//

import SwiftUI

struct DistrictListView: View {
	let items: [District] = [.example1, .example2, .example3]

		var body: some View {
			NavigationView {
				List(items, children: \.items) { row in
					Text(row.name)
				}
				.listStyle(.plain)
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItem(placement: .principal) {
						Text("전체 목록").font(.headline)
					}
				}
			}
			
			
		}
}

/*
 struct TotalList_Previews: PreviewProvider {
 static var previews: some View {
 TotalList()
 }
 }
 */
