//
//  TALATrackerUITests.swift
//  TALATrackerUITests
//
//  Created by Frederik Lohner on 4/Oct/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import XCTest

class TALATrackerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let csci2270ComputerScience2DataStructuresStaticText = tablesQuery.staticTexts["CSCI 2270: Computer Science 2: Data Structures"]
        csci2270ComputerScience2DataStructuresStaticText.tap()
        
        let brennanMStaticText = tablesQuery.staticTexts["Brennan M"]
        brennanMStaticText.tap()
        
        let backarrowButton = app.buttons["backArrow"]
        backarrowButton.tap()
        
        let kadeCStaticText = tablesQuery.staticTexts["Kade C"]
        kadeCStaticText.tap()
        backarrowButton.tap()
        app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).elementBoundByIndex(4).childrenMatchingType(.Other).elementBoundByIndex(0).buttons["backArrow"].tap()
        backarrowButton.tap()
        tablesQuery.staticTexts["CSCI 3104: Algorithms"].tap()
        backarrowButton.tap()
        
        let taLaSStaticText = app.staticTexts["TA/LA's"]
        taLaSStaticText.tap()
        brennanMStaticText.tap()
        backarrowButton.tap()
        taLaSStaticText.tap()
        kadeCStaticText.tap()
        csci2270ComputerScience2DataStructuresStaticText.tap()
        backarrowButton.tap()
        
  
    }
    
}
