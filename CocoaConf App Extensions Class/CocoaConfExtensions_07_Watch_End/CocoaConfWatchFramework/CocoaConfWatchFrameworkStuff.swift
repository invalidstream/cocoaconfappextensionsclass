//
//  CocoaConfWatchFrameworkStuff.swift
//  CocoaConfExtensions
//
//  Created by Chris Adamson on 11/4/15.
//  Copyright © 2015 Subsequently & Furthermore, Inc. All rights reserved.
//

import Foundation

// important: set the framework build target to "require only app-extension safe api"

public struct CocoaConfEvent {
    public var cityName: String
    public var startDate: NSDate
    public var endDate: NSDate
}

public enum EventRelativeTime: String {
    case Past = "Past"
    case Now = "Now"
    case Future = "Future"
}

public extension CocoaConfEvent {
    func relativeTime() -> EventRelativeTime {
        let now = NSDate()
        if self.endDate.compare(now) == .OrderedAscending {
            return .Past
        } else if self.startDate.compare(now) == .OrderedDescending {
            return .Future
        } else {
            return .Now
        }
    }
}

public var cocoaConf2015Events: [CocoaConfEvent] = {
    var formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    // spring 2015
    var chicago = CocoaConfEvent (cityName: "Chicago", startDate: formatter.dateFromString ("2015-03-26")!, endDate: formatter.dateFromString ("2015-03-29")!)
    var dc = CocoaConfEvent (cityName: "DC", startDate: formatter.dateFromString ("2015-04-09")!, endDate: formatter.dateFromString ("2015-04-10")!)
    var portland = CocoaConfEvent (cityName: "Portland", startDate: formatter.dateFromString ("2015-05-07")!, endDate: formatter.dateFromString ("2015-05-10")!)
    var austin = CocoaConfEvent (cityName: "Austin", startDate: formatter.dateFromString ("2015-05-21")!, endDate: formatter.dateFromString ("2015-05-24")!)
    
    // fall 2015
    var columbus = CocoaConfEvent (cityName: "Columbus", startDate: formatter.dateFromString ("2015-07-09")!, endDate: formatter.dateFromString ("2015-07-11")!)
    var boston = CocoaConfEvent (cityName: "Boston", startDate: formatter.dateFromString ("2015-09-17")!, endDate: formatter.dateFromString ("2015-09-19")!)
    var sanjose = CocoaConfEvent (cityName: "San Jose", startDate: formatter.dateFromString ("2015-11-05")!, endDate: formatter.dateFromString ("2015-11-07")!)
    
    
    
    
    return [chicago, dc, portland, austin, columbus, boston, sanjose]
}()

