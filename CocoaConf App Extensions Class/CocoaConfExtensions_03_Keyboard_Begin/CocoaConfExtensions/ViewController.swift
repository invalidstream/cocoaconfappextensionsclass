//
//  ViewController.swift
//  CocoaConfExtensions
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit
import CocoaConfFramework

class ViewController: UIViewController, UITableViewDataSource {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	// MARK - table view data source
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cocoaConf2015Events.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("TableCell") as UITableViewCell!
		let conf = cocoaConf2015Events[indexPath.row]
		cell.textLabel?.text = "\(conf.cityName): \(conf.relativeTime().rawValue)"
		return cell
	}
	
}

