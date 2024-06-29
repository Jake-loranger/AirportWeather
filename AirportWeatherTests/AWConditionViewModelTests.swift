//
//  AWConditionViewModelTests.swift
//  AirportWeatherTests
//
//  Created by Jacob  Loranger on 6/27/24.
//

import XCTest
@testable import AirportWeather

final class AWConditionViewModelTests: XCTestCase {
    
    var mockReport: WeatherReport!
    
    override func setUp() {
        super.setUp()
        
        let mockConditions = Conditions(
            text: "METAR KPWM 281851Z 34008KT 310V010 10SM CLR 23/07 A3011 RMK AO2 SLP196 T02280067",
            ident: "KPWM",
            dateIssued: "2024-06-28T18:51:00+0000",
            lat: 43.64564403491651,
            lon: -70.30861605624689,
            elevationFt: 76.0,
            tempC: 23.0,
            dewpointC: 7.0,
            pressureHg: 30.11,
            pressureHpa: 1019.684183,
            reportedAsHpa: false,
            densityAltitudeFt: 956,
            relativeHumidity: 36,
            flightRules: "vfr",
            cloudLayers: [Conditions.CloudLayerInfo(coverage: "clr", altitudeFt: 0.0, ceiling: false), Conditions.CloudLayerInfo(coverage: "bkn", altitudeFt: 1000.0, ceiling: false)],
            cloudLayersV2: [Conditions.CloudLayerInfo(coverage: "clr", altitudeFt: 0.0, ceiling: false)],
            weather: ["light rain", "mist"],
            visibility: Conditions.VisibilityInfo(distanceSm: 10.0, distanceQualifier: 10, prevailingVisSm: 10.0, prevailingVisDistanceQualifier: 10),
            wind: Conditions.WindInfo(speedKts: 8.0, direction: 340, from: 310, variable: true),
            period: Period(dateStart: "2024-06-28T18:00:00+0000", dateEnd: "2024-06-29T18:00:00+0000")
        )
        
        mockReport = WeatherReport(report: WeatherReport.Report(conditions: mockConditions, forecast: nil))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMetarFormatSuccess() {
        let viewModel = AWConditionViewModel(self.mockReport)
        
        XCTAssertEqual(viewModel.metarString, "METAR KPWM 281851Z 34008KT 310V010 10SM CLR 23/07 A3011 RMK AO2 SLP196 T02280067", "Metar string format given from AWConditionViewModel is incorrect.")
    }

    func testLatFormatSuccess() {
        let viewModel = AWConditionViewModel(self.mockReport)
        XCTAssertEqual(viewModel.latString, "43.64564403491651", "Lat string format given from AWConditionViewModel is incorrect.")
    }
    
    func testLonFormatSuccess() {
        let viewModel = AWConditionViewModel(self.mockReport)
        XCTAssertEqual(viewModel.lonString, "-70.30861605624689", "Lat string format given from AWConditionViewModel is incorrect.")
    }
    
    func testWeatherFormatSuccess() {
        let viewModel = AWConditionViewModel(mockReport)
        XCTAssertEqual(viewModel.weatherString, "light rain, mist", "Weather string format given from AWConditionViewModel is incorrect.")
    }
    
    func testTempFormatSuccess() {
        let viewModel = AWConditionViewModel(mockReport)
        XCTAssertEqual(viewModel.tempString, "23.0°C", "Temperature string format given from AWConditionViewModel is incorrect.")
    }
    
    func testDewFormatSuccess() {
        let viewModel = AWConditionViewModel(mockReport)
        XCTAssertEqual(viewModel.dewString, "7.0°C", "Dewpoint string format given from AWConditionViewModel is incorrect.")
    }
    
    func testHumidityFormatSuccess() {
        let viewModel = AWConditionViewModel(mockReport)
        XCTAssertEqual(viewModel.relativeHumidityString, "36%", "Humidity string format given from AWConditionViewModel is incorrect.")
    }
    
    func testPressureFormatSuccess() {
        let viewModel = AWConditionViewModel(mockReport)
        XCTAssertEqual(viewModel.pressureHpaString, "1019.7 hPa", "Pressure string format given from AWConditionViewModel is incorrect.")
    }
    
    func testSkyConditionFormatSuccess() {
        let viewModel = AWConditionViewModel(mockReport)
        XCTAssertEqual(viewModel.cloudLayersString, "clr at 0.0ft, bkn at 1000.0ft", "Sky Conditions string format given from AWConditionViewModel is incorrect.")
    }
    
    func testTimeIssuedFormatSuccess() {
        let viewModel = AWConditionViewModel(mockReport)
        XCTAssertEqual(viewModel.timeIssued, "Jun-28 18:51 UTC", "Time Issued string format given from AWConditionViewModel is incorrect.")
    }
}
