//
//  Every_swiftTests.swift
//  Every.swiftTests
//
//  Created by Samhan on 08/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//

import XCTest

/**
 Utility function to help fulfill expectations.
 
 - parameter seconds:    Delay value in seconds.
 - parameter completion: Handler that will be called after `delay`.
 */
func delay(seconds seconds: Double, completion: Void -> Void) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class Every_swiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testBasicTimerFunctionality()
    {
        
        let expectation = self.expectationWithDescription("Fires in 1 second")
        
        
        let startTime = NSDate()
        
        TimerManager.every(1.seconds, owner: self, elapsedHandler: {
            
            let fireTime = NSDate()
            
            let delta = fireTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate
            
            print(delta)
            
            if  delta >= 1 && delta <= 1.2 {
                expectation.fulfill()
            }
            
            return false
        })
        
        
        self.waitForExpectationsWithTimeout(4, handler: nil)
        
        
    }
    
    func testClearAllTimers() {
        let expectation = expectationWithDescription("Doesn't fires in 200 milliseconds")
        let timerOwner1 = NSObject()
        let timerOwner2 = NSObject()
        var fired1 = false
        var fired2 = false
        
        TimerManager.every(200.milliseconds, owner: timerOwner1) {
            fired1 = true
            return false
        }
        
        TimerManager.every(200.milliseconds, owner: timerOwner2) {
            fired2 = true
            return false
        }
        
        TimerManager.clearAllTimers()
        
        delay(seconds: 1.0) {
            if !fired1 && !fired2 {
                expectation.fulfill()
                return
            }
            
            if fired1 {
                XCTFail("First timer fired")
            }
            if fired2 {
                XCTFail("Second timer fired")
            }
        }
        
        waitForExpectationsWithTimeout(1.5, handler: nil)
    }
    
    func testClearTimersForOwner() {
        let expectation = expectationWithDescription("First timer fires and second doesn't")
        let timerOwner1 = NSObject()
        let timerOwner2 = NSObject()
        var fired1 = false
        var fired2 = false
        
        TimerManager.every(200.milliseconds, owner: timerOwner1) {
            fired1 = true
            return false
        }
        
        TimerManager.every(200.milliseconds, owner: timerOwner2) {
            fired2 = true
            return false
        }
        
        TimerManager.clearTimersForOwner(timerOwner2)
        
        delay(seconds: 1.0) {
            if fired1 && !fired2 {
                expectation.fulfill()
                return
            }
            
            if !fired1 {
                XCTFail("First timer not fired")
            }
            if fired2 {
                XCTFail("Second timer fired")
            }
        }
        
        waitForExpectationsWithTimeout(1.5, handler: nil)
    }
    
    func testClearTimer() {
        let expectation = expectationWithDescription("First timer fires and second doesn't")
        let timerOwner = NSObject()
        var fired1 = false
        var fired2 = false
        
        let _ = TimerManager.every(200.milliseconds, owner: timerOwner) {
            fired1 = true
            return false
        }
        
        let secondHandler = TimerManager.every(200.milliseconds, owner: timerOwner) {
            fired2 = true
            return false
        }
        
        TimerManager.clearTimer(secondHandler)
        
        delay(seconds: 1.0) {
            if fired1 && !fired2 {
                expectation.fulfill()
                return
            }
            
            if !fired1 {
                XCTFail("First timer not fired")
            }
            if fired2 {
                XCTFail("Second timer fired")
            }
        }
        
        waitForExpectationsWithTimeout(1.5, handler: nil)
    }
}
