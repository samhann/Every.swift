//
//  Every.swift
//  Every
//
//  Created by Samhan on 05/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//

import UIKit
import ObjectiveC

var AssociatedObjectHandle: UInt8 = 0


extension Array where Element : Equatable {

    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}


extension NSObject {
    var every_timers:[TimerManager] {
        get {
            let exists : [TimerManager]? =  objc_getAssociatedObject(self, &AssociatedObjectHandle) as? [TimerManager]
            
            if exists == nil {
                self.every_timers = []
            }
            
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! [TimerManager]
            
            
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func every_clearTimers()
    {
        self.every_timers.forEach { $0.clearTimer()}
        self.every_timers = []
    }
    
    func every_removeManager(let man : TimerManager)
    {
        self.every_timers.removeObject(man)
    }
}



class TimerManager : NSObject
{
    var timer       : NSTimer?
    var closure     : (()->Bool)?
    weak var owner  : NSObject?
    
    
    init( let closure : (()->Bool) ,  let owner : NSObject?)
    {
        self.closure = closure
        self.owner = owner
        super.init()
        self.owner?.every_timers.append(self)

    }
    
    func startTimerWithDuration(let duration : NSTimeInterval)
    {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: "executeClosure", userInfo: nil, repeats: true)
    }
    
    func executeClosure()
    {
        if let closure = self.closure {
            
            if let _ = owner {
                
                let result = closure()
                
                if !result {
                    self.clearTimer()
                }
                

            }
            else {
                self.clearTimer()
            }
            
        }
        
    }
    
    func clearTimer()
    {
        self.timer?.invalidate()
        self.timer = nil
        self.owner?.every_removeManager(self)
    }
    
    deinit
    {
        self.clearTimer()
    }
}


func every(let duration : NSDateComponents , let owner : NSObject, let closure : ()->Bool)
{
    let manager = TimerManager(closure: closure, owner: owner)

    manager.startTimerWithDuration(duration.durationInSeconds())
}
