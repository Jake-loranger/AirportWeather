//
//  MockWeatherReport.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 9/14/24.
//

import Foundation
@testable import AirportWeather

struct MockWeatherReport {
    
    static let mockWeatherReport: WeatherReport = WeatherReport(
        report: WeatherReport.Report(
            conditions: mockConditions,
            forecast: mockForecast
        )
    )
    
    static let mockConditions: Conditions = Conditions(
        text: "METAR KPWM 281851Z 34008KT 310V010 10SM CLR 23/07 A3011 RMK AO2 SLP196 T02280067",
        ident: "KPWM",
        dateIssued: "2024-06-28T18:51:00Z",
        lat: 43.64564403491651,
        lon: -70.30861605624689,
        elevationFt: 100.0,
        tempC: 23.0,
        dewpointC: 7.0,
        pressureHg: nil,
        pressureHpa: 1019.7,
        reportedAsHpa: true,
        densityAltitudeFt: 100,
        relativeHumidity: 36,
        flightRules: "VFR",
        cloudLayers: [mockCloudLayer1, mockCloudLayer2],
        cloudLayersV2: nil,
        weather: ["light rain", "mist"],
        visibility: mockVisibility,
        wind: mockWind,
        period: mockPeriod
    )
    
    static let mockForecast: Forecast = Forecast(
        text: "TAF 141720Z 1418/1518 10006KT P6SM SCT200",
        ident: "KPWM",
        dateIssued: "2024-06-28T12:00:00Z",
        period: mockPeriod,
        lat: 43.64564403491651,
        lon: -70.30861605624689,
        elevationFt: 100.0,
        conditions: [mockConditions]
    )
    
    static let mockCloudLayer1: Conditions.CloudLayerInfo = Conditions.CloudLayerInfo(
        coverage: "clr",
        altitudeFt: 0.0,
        ceiling: false
    )
    
    static let mockCloudLayer2: Conditions.CloudLayerInfo = Conditions.CloudLayerInfo(
        coverage: "bkn",
        altitudeFt: 1000.0,
        ceiling: true
    )
    
    static let mockVisibility: Conditions.VisibilityInfo = Conditions.VisibilityInfo(
        distanceSm: 10.0,
        distanceQualifier: nil,
        prevailingVisSm: 10.0,
        prevailingVisDistanceQualifier: nil
    )
    
    static let mockWind: Conditions.WindInfo = Conditions.WindInfo(
        speedKts: 8.0,
        direction: 340,
        from: nil,
        variable: true
    )
    
    static let mockPeriod: Period = Period(
        dateStart: "2024-06-28T12:00:00Z",
        dateEnd: "2024-06-28T18:51:00Z"
    )
}

