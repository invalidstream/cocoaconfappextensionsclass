//
//  TodayViewController.swift
//  CocoaConf Today
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit
import NotificationCenter
import CocoaConfFramework

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
		
		let confs = cocoaConf2015Events
		var previousLabel : UILabel? = nil
		for (index, conf) in confs.enumerate() {
			let label = UILabel ()
			label.translatesAutoresizingMaskIntoConstraints = false
			label.text =  "\(conf.cityName): \(conf.relativeTime().rawValue)"
			label.textColor = UIColor.whiteColor()
			self.view?.addSubview(label)
			let xConstraints = NSLayoutConstraint.constraintsWithVisualFormat("|-5-[label]-5-|", options: [], metrics: nil, views: ["label" : label])
			self.view.addConstraints(xConstraints)
			var yConstraints : [NSLayoutConstraint]? = nil
			if index == 0 {
				// first row
				yConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]", options: [], metrics: nil, views: ["label" : label])
			} else if index == confs.count - 1 {
				// last row
				yConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[previousLabel]-[label]", options: [], metrics: nil, views: ["previousLabel" : previousLabel!, "label" : label])
				yConstraints?.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:[label]-0-|", options: [], metrics: nil, views: ["label" : label]))
				
			} else {
				// middle row
				yConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[previousLabel]-[label]",
					options: [], metrics: nil,
					views: ["previousLabel" : previousLabel!, "label" : label])
			}
			self.view.addConstraints(yConstraints!)
			previousLabel = label
		}
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
    
}
