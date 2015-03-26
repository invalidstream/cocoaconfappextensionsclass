//
//  TodayViewController.swift
//  CocoaConf Today
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import UIKit
import NotificationCenter

/* LAYOUT CONSTRAINT STRINGS WE'LL NEED

FIRST ROW:
let xConstraints = NSLayoutConstraint.constraintsWithVisualFormat("|-5-[label]-5-|", options: nil, metrics: nil, views: ["label" : label])

MIDDLE ROW:
yConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[previousLabel]-[label]", options: nil, metrics: nil, views: ["previousLabel" : previousLabel!, "label" : label])

LAST ROW:
yConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[previousLabel]-[label]", options: nil, metrics: nil, views: ["previousLabel" : previousLabel!, "label" : label])
yConstraints?.extend(NSLayoutConstraint.constraintsWithVisualFormat("V:[label]-0-|", options: nil, metrics: nil, views: ["label" : label]))


*/


class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
		
        // BUILD UI IN CODE
        // TODO: WRITE IN CLASS
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
