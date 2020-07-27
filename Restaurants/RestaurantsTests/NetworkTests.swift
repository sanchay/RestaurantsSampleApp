//
//  NetworkTests.swift
//  RBCTestTests
//
//  Created by Sanchay Banerjee on 2020-07-26.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import XCTest
@testable import Restaurants

class NetworkTests: XCTestCase {
    
    let autocompleteFetcher = AutocompleteFetcher()
    let restaurantFetcher = RestaurantsFetcher()
    let detailFetcher = RestaurantDetailFetcher()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAutocomplete() {
        let expectation = self.expectation(description: "Fetch autocomplete terms")
        let location: LocationValue = .name("Toronto")
        autocompleteFetcher.fetch(name: "bag", location: location) { (result) in
            switch result {
            case .success(let model):
                if  model.terms.isEmpty {
                    XCTFail("Expecting bagels and more")
                }
                XCTAssertNotNil(model.terms.first)
                XCTAssertNotNil(model.terms.first?.text)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error during autocomplete term fetch: \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 3000)
    }
    
    func testRestaurantFetcher() {
        let expectation = self.expectation(description: "Fetch restaurants")
        let location: LocationValue = .name("Toronto")
        restaurantFetcher.fetch(name: "bagel", location: location) { (result) in
            switch result {
            case .success(let model):
                XCTAssert(model.businesses.count > 0, "No restaurants returned from API")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error during autocomplete term fetch: \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
