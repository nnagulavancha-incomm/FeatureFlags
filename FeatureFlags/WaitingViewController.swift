//
//  WaitingViewController.swift
//  FeatureFlags
//
//  Created by Naresh Kumar Nagulavancha on 6/25/18.
//  Copyright © 2018 incomm. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {

	@IBOutlet weak var justAMomentLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if RCValues.sharedInstance.fetchComplete {
			startAppForReal()
		}

		RCValues.sharedInstance.loadingDoneCallback = startAppForReal

		self.navigationController?.setNavigationBarHidden(true, animated: false)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: false)
	}

	func startAppForReal() {
		let vc = RCValues.sharedInstance.menuBased(forKey: .menuApearanceStyle)
		self.navigationController?.pushViewController(vc, animated: true)
	}


}
