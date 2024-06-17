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
        let conditions: Conditions
        let forecast: Forecast
    }
}

struct Conditions: Codable, Hashable {
    let text: String
    let ident: String
    // Add More
}

struct Forecast: Codable, Hashable {
    let text: String
    let ident: String
    let dateIssued: String
    let lat: Double
    let lon: Double
    // Add More
}
