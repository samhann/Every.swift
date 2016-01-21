//
//  ManagedTimerProtocol.swift
//  Every
//
//  Created by Pierre TACCHI on 08/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//
import Foundation

public protocol TimerManageable: class {
    func every(interval: NSDateComponents, elapsedHandler: TimerElapsedHandler) -> TimerHandler
    func clearTimer(handler: TimerHandler)
    func clearTimers()
    func clearAllTimers()
}

extension TimerManageable {
    public func every(interval: NSDateComponents, elapsedHandler: TimerElapsedHandler) -> TimerHandler {
        return TimerManager.every(interval, owner: self, elapsedHandler: elapsedHandler)
    }
    
    func clearTimer(handler: TimerHandler) {
        TimerManager.clearTimer(handler)
    }
    
    func clearTimers() {
        TimerManager.clearTimersForOwner(self)
    }
    
    func clearAllTimers() {
        TimerManager.clearAllTimers()
    }
}