//
//  ViewControllerFeature.swift
//  FeatureFlags
//
//  Created by Naresh Kumar Nagulavancha on 6/25/18.
//  Copyright © 2018 incomm. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerFeature: Feature {
	var vc: UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: self.id)
		return vc
	}
}
