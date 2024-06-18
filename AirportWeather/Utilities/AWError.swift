//
//  AWError.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import Foundation

enum AWError: String, Error {
    case invalidAirportName = "The airport symbol you entered does not exist. Please try again."
    case unableToCompleteRequest = "Unable to complete request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again."
    case unableToRetrieveRecents = "Unable to retrueve recent airport data at this time. Please try again."
    case unableToAddToRecents = "The airport cannot be saved to recents"
}
