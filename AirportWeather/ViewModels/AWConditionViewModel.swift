//
//  AWConditionViewModel.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/26/24.
//

import Foundation

class AWConditionViewModel {
    
    let weatherReport: WeatherReport
    
    
    init(_ weatherReport: WeatherReport) {
        self.weatherReport = weatherReport
    }
    
    
    var metarString: String {
        if let metar = self.weatherReport.report.conditions?.text {
            return metar
        } else {
            return "N/A"
        }
    }
    
    
    var latString: String {
        if let lat = self.weatherReport.report.conditions?.lat {
            return String(format: "%.14f", lat)
        } else {
            return "N/A"
        }
    }
    
    
    var lonString: String {
        if let lon = self.weatherReport.report.conditions?.lon {
            return String(format: "%.14f", lon)
        } else {
            return "N/A"
        }
    }
    
    
    var weatherString: String {
        guard let weather = self.weatherReport.report.conditions?.weather else {
            return "N/A"
        }
        
        if !weather.isEmpty {
            return weather.joined(separator: ", ")
        } else {
            return "Clear weather conditions"
        }
    }
    
    
    var tempString: String {
        if let temp = self.weatherReport.report.conditions?.tempC {
            return String(format: "%.1f°C", temp)
        } else {
            return "N/A"
        }
    }
    
    
    var dewString: String {
        if let dew = self.weatherReport.report.conditions?.dewpointC {
            return String(format: "%.1f°C", dew)
        } else {
            return "N/A"
        }
    }
    
    
    var windString: String {
        guard let wind = self.weatherReport.report.conditions?.wind, let windSpeed = wind.speedKts else {
            return "N/A"
        }
        
        let speedString = String(format: "%.1f", windSpeed)
        guard let direction = wind.direction else {
            return "\(speedString) knots"
        }

        let directionString = String(direction)
        return "\(speedString) knots at \(directionString)°"
    }
    
    
    var visibilityString: String {
        if let visibility = self.weatherReport.report.conditions?.visibility?.distanceSm {
            return String(format: "%.1f", visibility) +  "  sm"
        } else {
            return "N/A"
        }
    }
    
    
    var relativeHumidityString: String {
        if let humidity = self.weatherReport.report.conditions?.relativeHumidity {
            return String(humidity) + "%"
        } else {
            return "N/A"
        }
    }
    
    
    var pressureHpaString: String {
        if let pressureHpa = self.weatherReport.report.conditions?.pressureHpa {
            return String(format: "%.1f", pressureHpa) + " hPa"
        } else {
            return "N/A"
        }
    }

    
    var cloudLayersString: String {
        guard let cloudLayers = self.weatherReport.report.conditions?.cloudLayers else {
            return "N/A"
        }
        
        guard !cloudLayers.isEmpty else {
            return "No cloud layers"
        }
        
        let cloudLayerString = cloudLayers.compactMap { cloudLayer in
            if let coverage = cloudLayer.coverage, let altitude = cloudLayer.altitudeFt {
                return "\(coverage) at \(altitude)ft"
            } else {
                return nil
            }
        }.joined(separator: ", ")

        return cloudLayerString
    }
    
    
    var timeIssued: String {
        if let time = self.weatherReport.report.conditions?.dateIssued {
            return time.convertToDateFormat() + " UTC"
        } else {
            return "N/A"
        }
    }
}
