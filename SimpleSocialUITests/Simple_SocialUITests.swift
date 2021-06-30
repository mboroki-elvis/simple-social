//
//  Simple_SocialUITests.swift
//  Simple SocialUITests
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import XCTest

class SimpleSocialUITests: XCTestCase {
    var app: XCUIApplication?
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app?.launch()
    }

    override func tearDownWithError() throws {
        app?.terminate()
        app = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSelectHomeTable() throws {
        let table = app?.tables.matching(identifier: "HomeScreen")
        table?.cells.element(boundBy: 1).tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
