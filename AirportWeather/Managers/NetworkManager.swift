//
//  NetworkManager.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://qa.foreflight.com/weather/report/"
    
    private init() {}
    
    func getAirportWeatherData(for airportSymbol: String, completed: @escaping (Result<WeatherReport, AWError>) -> Void) {
        let endpoint = baseUrl + airportSymbol
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidAirportName))
            return
        }
        
        /* TO DO - Check if 1 has to be an Int */
        
        var request = URLRequest(url: url)
        request.addValue("1", forHTTPHeaderField: "ff-coding-exercise")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherReport.self, from: data)
                completed(.success(weatherData))
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }
}
