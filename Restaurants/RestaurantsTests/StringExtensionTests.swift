//
//  StringExtensionTests.swift
//  RBCTestTests
//
//  Created by Sanchay Banerjee on 2020-07-26.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import XCTest
@testable import Restaurants

class StringExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEscapedString() {
        let string1 = "test123"
        let result1 = string1.escapedString
        XCTAssertEqual(string1, result1)
        
        let string2 = "some word"
        let expectedResult = "some%20word"
        let result2 = string2.escapedString
        XCTAssertEqual(expectedResult, result2)
    }
}
