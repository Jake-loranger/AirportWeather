//
//  NetworkManagerTests.swift
//  AirportWeatherTests
//
//  Created by Jacob  Loranger on 7/10/24.
//

import XCTest
@testable import AirportWeather

final class NetworkManagerTests: XCTestCase {

    let mockURLSession = MockURLSession()
    
    override func setUp() {
        super.setUp()

        self.mockURLSession.mockData = nil
        self.mockURLSession.mockResponse = nil
        self.mockURLSession.mockError = nil

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testGetAirportWeatherDataSuccess() {
        
        let mockJSON = """
        {
            "report": {}
        }
        """
        self.mockURLSession.mockData = mockJSON.data(using: .utf8)
        self.mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        self.mockURLSession.mockError = nil
        
        let mockNetworkManager = NetworkManager(protocolSession: self.mockURLSession)
        
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
        
        self.mockURLSession.mockData = nil
        self.mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        self.mockURLSession.mockError = nil
        
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

    func testGetAirportWeatherDataUnableToCompleteRequest() {
        self.mockURLSession.mockData = nil
        self.mockURLSession.mockResponse = nil
        self.mockURLSession.mockError = Error()

        mockNetworkManager.getAirportWeatherData(for: "") { result in
            switch result {
                case .success(_): 
                    XCTFail("GetAirportWeatherData network call returns an data when it should return an unableToCompleteRequest error")
                case .failure(let error): 
                    XCTAssertEqual(error.rawValue, "Unable to complete request. Please check your internet connection.")
            }
        }
    }
}

