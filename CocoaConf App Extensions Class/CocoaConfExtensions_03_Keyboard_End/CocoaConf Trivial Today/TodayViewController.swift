//
//  TodayViewController.swift
//  CocoaConf Trivial Today
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
	@IBAction func handleButtonTapped(sender: AnyObject) {
		if let url = NSURL(string:"cocoaconf-extensions-trivial://foo") {
			self.extensionContext?.openURL(url, completionHandler: nil)
		}
	}
}
