//
//  AirportWeatherTests.swift
//  AirportWeatherTests
//
//  Created by Jacob  Loranger on 6/27/24.
//

import XCTest

final class AirportWeatherTests: XCTestCase {

    func testAll() {
        AWConditionViewModelTests().runTests()
        AWDetailsVCTests().runTests()
        AWSearchVCTests().runTests()
        NetworkManagerTests().runTests()
    }
}
