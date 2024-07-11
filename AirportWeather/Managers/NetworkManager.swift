//
//  NetworkManager.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import Foundation

protocol NetworkProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkProtocol { }

class NetworkManager {
    private let baseUrl = "https://qa.foreflight.com/weather/report/"
    let networkProtocol: NetworkProtocol
    
    init(protocolSession: NetworkProtocol = URLSession.shared) {
        self.networkProtocol = protocolSession
    }
    
    
    func getAirportWeatherData(for airportSymbol: String, completed: @escaping (Result<WeatherReport, AWError>) -> Void) {
        let endpoint = baseUrl + airportSymbol
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidAirportName))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("1", forHTTPHeaderField: "ff-coding-exercise")
        
        let task = networkProtocol.dataTask(with: request) { data, response, error in
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
