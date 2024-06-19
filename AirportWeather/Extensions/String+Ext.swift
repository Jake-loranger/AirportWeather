//
//  String+Ext.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/18/24.
//

import Foundation

extension String {
    func convertToDateFormat() -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            guard let date = inputFormatter.date(from: self) else {
                return "Invalid Date"
            }
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM-dd HH:mm"
            outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            return outputFormatter.string(from: date)
        }
}
