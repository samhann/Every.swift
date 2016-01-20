//
//  NSDateComponentsExtensions.swift
//  Every
//
//  Created by Samhan on 05/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//

import Foundation

private struct DateConstants {
    static let secPerMinute         = 60
    static let secPerHour           = secPerMinute * 60
    static let secPerDay            = secPerHour * 24
    static let secPerMonth          = secPerDay * 30
    static let secPerYear           = secPerMonth * 12
    static let secPerNanosecond     = 1e-9
}

public extension NSDateComponents
{
    static public func zero()->NSDateComponents
    {
        let new         = NSDateComponents()
        new.hour        = 0
        new.minute      = 0
        new.second      = 0
        new.day         = 0
        new.month       = 0
        new.year        = 0
        new.nanosecond  = 0
        return new
    }
    
    func durationInSeconds() -> NSTimeInterval
    {
        let nanosecond = Double(self.nanosecond) * DateConstants.secPerNanosecond
        let secAndMin = self.second + self.minute * DateConstants.secPerMinute
        let hourAndDay = self.hour * DateConstants.secPerHour + self.day * DateConstants.secPerDay
        let monthAndYear = self.month * DateConstants.secPerMonth + self.year * DateConstants.secPerYear
        return NSTimeInterval(Double(secAndMin) + Double(hourAndDay) + Double(monthAndYear) + nanosecond)
    }
    
}


public extension Int {
    public var hours: NSDateComponents {
            let components = NSDateComponents.zero()
            components.hour = self
            return components
    }
    
    public var minutes: NSDateComponents {
            let components = NSDateComponents.zero()
            components.minute = self
            return components
    }
    
    public var seconds: NSDateComponents {
            let components = NSDateComponents.zero()
            components.second = self
            return components
    }
    
    public var nanoseconds: NSDateComponents {
        let components = NSDateComponents.zero()
        components.nanosecond = self
        return components
    }
    
    
    public var milliseconds: NSDateComponents {
        let components = NSDateComponents.zero()
        components.nanosecond = self * 1000000
        return components
    }
    
    public var days: NSDateComponents {
            let components = NSDateComponents.zero()
            components.day = self
            return components
    }
    
    public var months : NSDateComponents {
            let components = NSDateComponents.zero()
            components.month = self
            return components
    }
    
    public var weeks: NSDateComponents {
            let components = NSDateComponents.zero()
            components.day = self*7
            return components
    }
    
    
    public var years: NSDateComponents {
        let components = NSDateComponents.zero()
        components.year = self
        return components
    }
}

public func +(compOne: NSDateComponents , compTwo: NSDateComponents) -> NSDateComponents {
    let newComponent = NSDateComponents()
    newComponent.minute     =   compOne.minute      + compTwo.minute
    newComponent.second     =   compOne.second      + compTwo.second
    newComponent.hour       =   compOne.hour        + compTwo.hour
    newComponent.day        =   compOne.day         + compTwo.day
    newComponent.month      =   compOne.month       + compTwo.month
    newComponent.year       =   compOne.year        + compTwo.year
    newComponent.nanosecond =   compOne.nanosecond  + compTwo.nanosecond
    return newComponent
}


public func -(frmDate: NSDate , toDate: NSDate) -> NSDateComponents{
    return NSCalendar.currentCalendar().components([.Year, .Month, .Day, .Hour, .Minute, .Second,.Nanosecond], fromDate: toDate, toDate: frmDate, options: NSCalendarOptions(rawValue:0))
}