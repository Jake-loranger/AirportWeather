//
//  AWSearchVCTests.swift
//  AirportWeatherTests
//
//  Created by Jacob  Loranger on 7/11/24.
//

import XCTest

final class AWSearchVCTests: XCTestCase {

     var searchVC: AWSearchVC!

    override func setUp() {
        super.setUp()
        searchVC = AWSearchVC()
    }

    override func tearDown() {
        searchVC = nil
        super.tearDown()
    }

    func testPushDetailsVCWithAirportEntered() {
        searchVC.airportTextField.text = "KLAX"
        searchVC.pushDetailsVC()

        XCTAssertTrue(searchVC.navigationController?.topViewController is AWDetailsVC)
    }

    func testPushDetailsVCWithNoAirportEntered() {
        searchVC.airportTextField.text = ""
        searchVC.pushDetailsVC()

        XCTAssertNotNil(searchVC.presentedViewController)
        XCTAssertTrue(searchVC.presentedViewController is UIAlertController)
    }

    func testPushDetailsVCWithInvalidAirportSymbol() {
        searchVC.airportTextField.text = "ThisIsNotAnAirportSymbol"
        searchVC.pushDetailsVC

        XCTAssertTrue(searchVC.presentedViewController is UIAlertController)
    }
}
