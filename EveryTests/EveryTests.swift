//
//  Every_swiftTests.swift
//  Every.swiftTests
//
//  Created by Samhan on 08/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//

import XCTest


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
    
    
    
}
