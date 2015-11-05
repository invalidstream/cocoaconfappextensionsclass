//
//  InterfaceController.swift
//  CocoaConf Watch App Extension
//
//  Created by Chris Adamson on 11/4/15.
//  Copyright © 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import WatchKit
import Foundation
import CocoaConfWatchFramework

class InterfaceController: WKInterfaceController {

    @IBOutlet var conferenceLabel: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        var found = false
        let confs = cocoaConf2015Events
        for conf in confs {
            if conf.relativeTime() == .Now {
                conferenceLabel.setText(conf.cityName)
                found = true
                break
            }
        }
        if !found {
            conferenceLabel.setText("none")
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
