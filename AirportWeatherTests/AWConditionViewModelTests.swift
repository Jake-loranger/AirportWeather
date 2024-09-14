//
//  AWConditionViewModelTests.swift
//  AirportWeatherTests
//
//  Created by Jacob  Loranger on 6/27/24.
//

import XCTest
@testable import AirportWeather

final class AWConditionViewModelTests: XCTestCase {
    
    var viewModel: AWConditionViewModel!
    var mockReport: WeatherReport!
    
    override func setUp() {
        super.setUp()
        mockReport = MockWeatherReport.mockWeatherReport
        viewModel = AWConditionViewModel(self.mockReport)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMetarFormatSuccess() {
        XCTAssertEqual(viewModel.metarString, "METAR KPWM 281851Z 34008KT 310V010 10SM CLR 23/07 A3011 RMK AO2 SLP196 T02280067", "Metar string format given from AWConditionViewModel is incorrect.")
    }

    func testLatFormatSuccess() {
        XCTAssertEqual(viewModel.latString, "43.64564403491651", "Lat string format given from AWConditionViewModel is incorrect.")
    }
    
    func testLonFormatSuccess() {
        XCTAssertEqual(viewModel.lonString, "-70.30861605624689", "Lat string format given from AWConditionViewModel is incorrect.")
    }
    
    func testWeatherFormatSuccess() {
        XCTAssertEqual(viewModel.weatherString, "light rain, mist", "Weather string format given from AWConditionViewModel is incorrect.")
    }
    
    func testTempFormatSuccess() {
        XCTAssertEqual(viewModel.tempString, "23.0°C", "Temperature string format given from AWConditionViewModel is incorrect.")
    }
    
    func testDewFormatSuccess() {
        XCTAssertEqual(viewModel.dewString, "7.0°C", "Dewpoint string format given from AWConditionViewModel is incorrect.")
    }
    
    func testHumidityFormatSuccess() {
        XCTAssertEqual(viewModel.relativeHumidityString, "36%", "Humidity string format given from AWConditionViewModel is incorrect.")
    }
    
    func testPressureFormatSuccess() {
        XCTAssertEqual(viewModel.pressureHpaString, "1019.7 hPa", "Pressure string format given from AWConditionViewModel is incorrect.")
    }
    
    func testSkyConditionFormatSuccess() {
        XCTAssertEqual(viewModel.cloudLayersString, "clr at 0.0ft, bkn at 1000.0ft", "Sky Conditions string format given from AWConditionViewModel is incorrect.")
    }
    
    func testTimeIssuedFormatSuccess() {
        XCTAssertEqual(viewModel.timeIssued, "Jun-28 18:51 UTC", "Time Issued string format given from AWConditionViewModel is incorrect.")
    }
}
