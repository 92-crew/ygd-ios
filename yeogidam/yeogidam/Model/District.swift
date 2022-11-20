//
//  SmokingArea.swift
//  yeogidam
//
//  Created by Kangwook Lee on 2022/11/20.
//

import Foundation

struct District: Identifiable {
	let id = UUID()
	let name: String
	var items: [District]?
}

extension District {
	// some example websites
	static let temp1 = District(name: "신사동")
	static let temp2 = District(name: "구의동")
	static let temp3 = District(name: "자양동")
	static let temp4 = District(name: "신길동")
	
	// some example groups
	static let example1 = District(name: "강남구", items: [.temp1,])
	static let example2 = District(name: "광진구", items: [.temp2, .temp3])
	static let example3 = District(name: "영등포구", items: [.temp4])
}
