//
//  CocoaConfFrameworkStuff.swift
//  CocoaConfExtensions
//
//  Created by Chris Adamson on 3/25/15.
//  Copyright (c) 2015 Subsequently & Furthermore, Inc. All rights reserved.
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
    var boston = CocoaConfEvent (cityName: "Boston", startDate: formatter.dateFromString ("2015-09-17")!, endDate: formatter.dateFromString ("2015-09-19")!)
    var sanjose = CocoaConfEvent (cityName: "San Jose", startDate: formatter.dateFromString ("2015-11-05")!, endDate: formatter.dateFromString ("2015-11-07")!)
    var chicago = CocoaConfEvent (cityName: "Chicago", startDate: formatter.dateFromString ("2016-03-24")!, endDate: formatter.dateFromString ("2016-03-26")!)
	return [boston, sanjose, chicago]
	}()

