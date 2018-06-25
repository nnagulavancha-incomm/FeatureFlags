//
//  AppDelegate.swift
//  FeatureFlags
//
//  Created by Naresh Kumar Nagulavancha on 6/20/18.
//  Copyright © 2018 incomm. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var remoteConfig: RemoteConfig!

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		FirebaseApp.configure()
		let _ = RCValues.sharedInstance

		return true
	}
}

