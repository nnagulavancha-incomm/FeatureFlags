//
//  RCConfig.swift
//  FeatureFlags
//
//  Created by Naresh Kumar Nagulavancha on 6/20/18.
//  Copyright © 2018 incomm. All rights reserved.
//

import Foundation
import Firebase

enum ValueKey: String {
	case menuApearanceStyle
	case isMapViewEnabled
	case isHistoryEnabled
	case isDashboardEnabled
}

class AppConext {
	class func tabBarFeatures() -> [ValueKey] {
		return [ValueKey.isMapViewEnabled, ValueKey.isDashboardEnabled, ValueKey.isHistoryEnabled]
	}
}

class ViewControllerNode {
	func getViewControllerFeature(key: ValueKey) -> UIViewController {
		var vc: UIViewController?
		var title = ""
		var id = ""

		switch key {
		case .isMapViewEnabled:
			title = "Map View"
			id = "mapViewController"
		case .isHistoryEnabled:
			title = "History"
			id = "historyViewController"
		case .isDashboardEnabled:
			title = "Dashboard"
			id = "dashboardViewController"
		default:
			break
		}
		vc = ViewControllerFeature.init(title: title, id: id).vc
		return vc!
	}
}

class RCValues {
	static let sharedInstance = RCValues()

	var loadingDoneCallback: (() -> Void)?
	var fetchComplete = false

	private init() {
		loadDefaultValues()
		fetchCloudValue()
	}

	func loadDefaultValues(){
		let appDefaults: [String: Any?] = [
			ValueKey.menuApearanceStyle.rawValue : "menu",
			ValueKey.isHistoryEnabled.rawValue: true,
			ValueKey.isMapViewEnabled.rawValue: true,
			ValueKey.isDashboardEnabled.rawValue: true
		]

		RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
	}

	func fetchCloudValue() {
		let fetchDuration: TimeInterval = 0

		activateDebugMode()

		RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) {
			[weak self] (status, error) in

			if let error = error {
				print("Got error \(error)")
				return
			}

			RemoteConfig.remoteConfig().activateFetched()
			print("Retrived values from the cloud")
			print(RemoteConfig.remoteConfig().configValue(forKey: "menuApearanceStyle").stringValue)
			self?.fetchComplete = true
			self?.loadingDoneCallback?()
		}
	}

	func activateDebugMode() {
		let settings = RemoteConfigSettings(developerModeEnabled: true)
		RemoteConfig.remoteConfig().configSettings  = settings
	}

	func menuBased(forKey key: ValueKey) -> UIViewController {
		let val = RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "menu"
		let storyboard = UIStoryboard(name: "Main", bundle: nil)

		if val == "tab" {
			let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as! TabViewController
			return vc
		}

		let vc = storyboard.instantiateViewController(withIdentifier: "menViewController") as! MenuViewController
		return vc
	}

	func getViewControllers() -> [UIViewController] {
		let vcs = AppConext.tabBarFeatures().filter{
			self.bool(forKey: $0)
			}.map {
				ViewControllerNode().getViewControllerFeature(key: $0)
			}
		return vcs
	}

	func bool(forKey key: ValueKey) -> Bool {
		return RemoteConfig.remoteConfig()[key.rawValue].boolValue
	}

	func string(forKey key: ValueKey) -> String {
		return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
	}

	func double(forKey key: ValueKey) -> Double {
		if let numberValue = RemoteConfig.remoteConfig()[key.rawValue].numberValue {
			return numberValue.doubleValue
		} else {
			return 0.0
		}
	}
}
