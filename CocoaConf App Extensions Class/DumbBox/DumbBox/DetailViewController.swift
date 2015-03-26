//
//  DetailViewController.swift
//  DumbBox
//
//  Created by Chris Adamson on 3/15/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


	@IBOutlet weak var detailWebView: UIWebView!

	var detailItem: AnyObject? {
		didSet {
		    // Update the view.
		    self.configureView()
		}
	}

	func configureView() {
		// Update the user interface for the detail item.
		if let url = self.detailItem as? NSURL {
			let request = NSURLRequest(URL: url)
			self.detailWebView?.loadRequest(request)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.configureView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	

}

