//
//  AWDetailsVCTests.swift
//  AirportWeatherTests
//
//  Created by Jacob  Loranger on 7/11/24.
//

import XCTest

final class AWDetailsVCTests: XCTestCase {

    var detailsVC: AWDetailsVC!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        detailsVC = nil
        super.tearDown()
    }
    
    func testFetchWeatherDataSuccess() {
        detailsVC = AWDetailsVC(airportSymbol: "KLAX")

        XCTAssertNotNil(detailsVC.conditionsVC)
        XCTAssertNotNil(detailsVC.weatherReport)
        XCTAssertTrue(.navigationController?.topViewController is AWConditionVC)
    }

    func testFetchWeatherDataError() {
        detailsVC = AWDetailsVC(airportSymbol: "ThisIsNotAnAirportSymbol")
        
        XCTAssertNil(detailsVC.conditionsVC)
        XCTAssertNotNil(detailsVC.presentedViewController)
        XCTAssertTrue(detailsVC.presentedViewController is UIAlertController)
    }
}
