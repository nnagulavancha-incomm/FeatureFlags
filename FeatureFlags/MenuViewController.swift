//
//  ViewController.swift
//  FeatureFlags
//
//  Created by Naresh Kumar Nagulavancha on 6/20/18.
//  Copyright © 2018 incomm. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

	@IBOutlet weak var primaryView: UIView!
	@IBOutlet weak var trailingC: NSLayoutConstraint!
	@IBOutlet weak var leadingC: NSLayoutConstraint!

	var menuIsVisible = false

	var features: [UIViewController] = []

	@IBAction func item1Clicked(_ sender: Any) {
		let vc = UIViewController()
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction func item2Clicked(_ sender: Any) {
		let vc = UIViewController()
		navigationController?.pushViewController(vc, animated: true)
	}

	@objc func menuBtnTapped(_ sender: Any) {

		if !menuIsVisible {
			leadingC.constant = 150
			trailingC.constant = -150
			menuIsVisible = true
		} else {
			leadingC.constant = 0
			trailingC.constant = 0
			menuIsVisible = false
		}

		menuIsVisible = !menuIsVisible

		UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
			self.view.layoutIfNeeded()
		}) { (animationComplete) in
			print("The animation is complete!")
		}

	}

	func setUpMenuItems() {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.alignment = .leading
		stackView.spacing = 8

		for feature in features {
			let btn = UIButton(type: .system)
			btn.setTitle(feature.title, for: .normal)
			stackView.addArrangedSubview(btn)
		}

		stackView.translatesAutoresizingMaskIntoConstraints = false

		self.primaryView.addSubview(stackView)

		stackView.topAnchor.constraint(equalTo: primaryView.topAnchor, constant: 8).isActive = true
		stackView.leadingAnchor.constraint(equalTo: primaryView.leadingAnchor, constant: 8).isActive = true

	}

	override func viewDidLoad() {
		super.viewDidLoad()
		features =  RCValues.sharedInstance.getViewControllers()
		setUpMenuItems()
		title = "Feature Flags"
		let btn = UIBarButtonItem(title: "Menu", style: .done, target: self, action: #selector(self.menuBtnTapped(_:)))
		navigationItem.leftBarButtonItem = btn
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

