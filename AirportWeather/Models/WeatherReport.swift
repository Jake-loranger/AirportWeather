//
//  WeatherReport.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import Foundation

struct WeatherReport: Codable {
    let report: Report
    
    struct Report: Codable {
        let conditions: Conditions?
        let forecast: Forecast?
    }
}

struct Conditions: Codable, Hashable {
    let text: String?
    let ident: String?
    let dateIssued: String?
    let lat: Double?
    let lon: Double?
    let elevationFt: Double?
    let tempC: Double?
    let dewpointC: Double?
    let pressureHg: Double?
    let pressureHpa: Double?
    let reportedAsHpa: Bool?
    let densityAltitudeFt: Int?
    let relativeHumidity: Int?
    let flightRules: String?
    let cloudLayers: [CloudLayerInfo]?
    let cloudLayersV2: [CloudLayerInfo]?
    let weather: [String]?
    let visibility: VisibilityInfo?
    let wind: WindInfo?
    let period: Period?
    
    struct CloudLayerInfo: Codable, Hashable  {
        let coverage: String?
        let altitudeFt: Double?
        let ceiling: Bool?
    }
    
    struct VisibilityInfo: Codable, Hashable  {
        let distanceSm: Double?
        let distanceQualifier: Int?
        let prevailingVisSm: Double?
        let prevailingVisDistanceQualifier: Int?
    }
    
    struct WindInfo: Codable, Hashable  {
        let speedKts: Double?
        let direction: Int?
        let from: Int?
        let variable: Bool?
    }
}

struct Forecast: Codable, Hashable {
    let text: String?
    let ident: String?
    let dateIssued: String?
    let period: Period?
    let lat: Double?
    let lon: Double?
    let elevationFt: Double?
    let conditions: [Conditions]?
}

struct Period: Codable, Hashable {
    let dateStart: String?
    let dateEnd: String?
}
