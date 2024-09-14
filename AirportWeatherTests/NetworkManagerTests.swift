//
//  NetworkManagerTests.swift
//  AirportWeatherTests
//
//  Created by Jacob  Loranger on 9/14/24.
//

import XCTest
@testable import AirportWeather

final class NetworkManagerTests: XCTestCase {
    
    var mockNetworkManager: NetworkManager!
    let mockUrlSession = MockURLSession()

    override func setUp() {
        super.setUp()
        mockNetworkManager = NetworkManager(protocolSession: mockUrlSession)
    }
    
    override func tearDown() {
        super.tearDown()
        mockUrlSession.mockData = nil
        mockUrlSession.mockResponse = nil
        mockUrlSession.mockError = nil
    }
    
    func testGetAirportWeatherDataSuccess() {
        let mockData = "{\"report\": {}}".data(using: .utf8)
        mockUrlSession.mockData = mockData
        mockUrlSession.mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockUrlSession.mockError = nil
                
        mockNetworkManager.getAirportWeatherData(for: "AnAirportSymbol") { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail("Expected success but got failure with error: \(error)")
            }
        }
    }
    
    func testGetAirportWeatherDataInvalidResponse() {
        mockUrlSession.mockData = nil
        mockUrlSession.mockResponse = HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        mockUrlSession.mockError = nil
                
        mockNetworkManager.getAirportWeatherData(for: "AnAirportSymbol") { result in
            switch result {
            case .success( _):
                XCTFail("GetAirportWeatherData network call returns data when it should return an error")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testGetAirportWeatherDataUnableToCompleteRequest() {
        mockUrlSession.mockData = nil
        mockUrlSession.mockResponse = nil
        mockUrlSession.mockError = NSError()
        
        mockNetworkManager.getAirportWeatherData(for: "AnAirportSymbol") { result in
            switch result {
            case .success( _):
                XCTFail("GetAirportWeatherData network call returns data when it should return an error")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
