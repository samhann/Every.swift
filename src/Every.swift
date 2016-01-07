//
//  Every.swift
//  Every
//
//  Created by Samhan on 05/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//

import Foundation
import ObjectiveC

var AssociatedObjectHandle: UInt8 = 0

internal class DeallocWatcher : NSObject {
    
    weak var owner : NSObject?
    
    init( owner : NSObject?) {
        self.owner = owner
        super.init()
        objc_setAssociatedObject(self.owner, &AssociatedObjectHandle, self, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    deinit {
        
        print("Auto deregistration successful !")
        guard let timerOwner = self.owner else { return }
        TimerManager.clearTimersForOwner(timerOwner)
    }
}


public typealias TimerElapsedHandler = () -> Bool

public struct TimerHandler{
    public var isValid: Bool {
        guard let timer = item?.timer else { return false }
        return timer.valid
    }
    private let item: TimerItem?
    private init(item: TimerItem) {
        self.item = item
    }
}

internal class TimerItem: NSObject {
    private weak var timer: NSTimer?
    private var elapsedHandler: TimerElapsedHandler
    private weak var owner: AnyObject?
    
    private init(duration: NSTimeInterval, owner: AnyObject, elapsedHandler: TimerElapsedHandler) {
        self.owner = owner
        self.elapsedHandler = elapsedHandler
        super.init()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: "timerElapsed:", userInfo: nil, repeats: true)
    }
    
    internal func timerElapsed(timer: NSTimer) {
        guard timer == self.timer else { return }
        if !elapsedHandler() {
            clearTimer()
            TimerManager.clearTimer(timer)
        }
    }
    
    private func clearTimer() {
        self.timer?.invalidate()
    }
}

public struct TimerManager {
    private static var timers = [TimerItem]()
    
    public static func every(interval: NSDateComponents, owner: AnyObject, elapsedHandler: TimerElapsedHandler) -> TimerHandler {
        let handler = TimerItem(duration: interval.durationInSeconds(), owner: owner, elapsedHandler: elapsedHandler)
        timers.append(handler)
        if let nsObject = owner as? NSObject {
                DeallocWatcher(owner: nsObject)
        }

        return TimerHandler(item: handler)
    }
    
    public static func clearTimer(handler: TimerHandler) {
        guard let timer = handler.item?.timer where timer.valid else { return }
        
        func timerItemPredicate(item: TimerItem) -> Bool {
            return item.timer == timer
        }
        
        if let index = timers.indexOf(timerItemPredicate) {
            handler.item?.clearTimer()
            timers.removeAtIndex(index)
        }
    }
    
    public static func clearTimersForOwner(owner: AnyObject) {
        timers.filter({ $0.owner === owner }).forEach({ $0.clearTimer() })
        timers = timers.filter {
            $0.owner !== owner
        }
    }
    
    public static func clearAllTimers() {
        timers.forEach {
            $0.clearTimer()
        }
        timers.removeAll()
    }
    
    private static func clearTimer(timer: NSTimer) {
        func timerItemPredicate(item: TimerItem) -> Bool {
            return item.timer == timer
        }
        
        if let index = timers.indexOf(timerItemPredicate) {
            timers.removeAtIndex(index)
        }
        print("Timer cleared !")
    }
}