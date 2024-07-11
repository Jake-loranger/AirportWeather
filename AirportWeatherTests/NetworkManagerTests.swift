//
//  NetworkManagerTests.swift
//  AirportWeatherTests
//
//  Created by Jacob  Loranger on 7/10/24.
//

import XCTest
@testable import AirportWeather

final class NetworkManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testGetAirportWeatherDataSuccess() {
        let mockURLSession = MockURLSession()
        
        let mockJSON = """
        {
            "report": {}
        }
        """
        mockURLSession.mockData = mockJSON.data(using: .utf8)
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockURLSession.mockError = nil
        
        let mockNetworkManager = NetworkManager(protocolSession: mockURLSession)
        
        mockNetworkManager.getAirportWeatherData(for: "") { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "GetAirportWeatherData network call successfully fetches data.")
            case .failure( _):
                XCTFail("GetAirportWeatherData network call returns an error")
            }
        }
    }
    
    func testGetAirportWeatherDataInvalidResponse() {
        let mockURLSession = MockURLSession()
        
        mockURLSession.mockData = nil
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        mockURLSession.mockError = nil
        
        let mockNetworkManager = NetworkManager(protocolSession: mockURLSession)
        
        mockNetworkManager.getAirportWeatherData(for: "") { result in
            switch result {
            case .success( _):
                XCTFail("GetAirportWeatherData network call returns an data when it should return an invalidResponse error")
            case .failure(let error):
                XCTAssertEqual(error.rawValue, "Invalid response from the server. Please try again.")
            }
        }
    }
}

