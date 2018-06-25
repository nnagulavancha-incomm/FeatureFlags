//
//  Feature.swift
//  FeatureFlags
//
//  Created by Naresh Kumar Nagulavancha on 6/25/18.
//  Copyright © 2018 incomm. All rights reserved.
//

import Foundation

class Feature {
	let headTitle: String
	let id: String

	init(title: String, id: String) {
		self.headTitle = title
		self.id = id
	}
}
