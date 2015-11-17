//
//  TALATrackerTests.swift
//  TALATrackerTests
//
//  Created by Frederik Lohner on 4/Oct/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import XCTest
@testable import TALATracker

class TALATrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testExample() {
        
    }
    func tesPOSTFunc() {
       XCTAssertFalse(sendFirstPOST({ () -> () in }), "True")
    }
    
    func testStruct() {
        var json = JSONReturn()
        json.className = "Class"
        json.day = "Mon"
        json.location = "CSEL"
        json.name = "Fred"
        json.time = "12:00"
        XCTAssertEqual(json.className, "Class")
        XCTAssertEqual(json.day, "Mon")
        XCTAssertEqual(json.location, "CSEL")
        XCTAssertEqual(json.name, "Fred")
        XCTAssertEqual(json.time, "12:00")
    }
    
    func testInitialJSON() {
        var testArray = []
        BaseJSONGet(&testArray) { () -> () in
            XCTAssertNotNil(testArray)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
