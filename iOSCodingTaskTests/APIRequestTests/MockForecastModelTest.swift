//
//  MockForecastModelTest.swift
//  iOSCodingTaskTests
//
//  Created by Ivan Vasilev on 4/1/23.
//

import XCTest
@testable import iOSCodingTask

class MockForecastModelTest: XCTestCase {
    
    private var forecastModel: ForecastModel?
    
    override func setUp() {
        super.setUp()
        
        let urlSession: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [MockURLProtocol.self]
            return URLSession(configuration: configuration)
        }()
        
        forecastModel = ForecastModel(requestExecutableProtocol: MockAPIClient(session: urlSession))
    }
    
    override func tearDown() {
        super.tearDown()
        forecastModel = nil
    }
    
    func test_SuccessCase() {
        let statusCode = Int.random(in: 200..<299)
        guard let url = URL(string: "http://127.0.0.1:8080"),
              let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil) else {
            XCTFail("Failed to prepare response")
            return
        }
        
        let expectation = XCTestExpectation(description: "Perform a request")
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(response)
        
        forecastModel?.getWeatherData(completion: { response in
            switch response {
            case .success(()):
                XCTAssertEqual(self.forecastModel?.forecast.count, 3)
                XCTAssertEqual(self.forecastModel?.forecast[0].date, "2023-03-30")
                expectation.fulfill()
            case .failure(_):
                XCTFail()
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 10)
    }
    
    func test_FailureCase() {
        let expectation = XCTestExpectation(description: "Perform a request")
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.error(.badResponse)
        
        forecastModel?.getWeatherData(completion: { response in
            switch response {
            case .success(()):
                XCTFail()
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, .badResponse)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 10)
    }
    
    func test_GetForecast() {
        let statusCode = Int.random(in: 200..<299)
        guard let url = URL(string: "http://127.0.0.1:8080"),
              let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil) else {
            XCTFail("Failed to prepare response")
            return
        }
        
        let expectation = XCTestExpectation(description: "Perform a request")
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(response)
        
        forecastModel?.getWeatherData(completion: { response in
            switch response {
            case .success(()):
                let daysCount = self.forecastModel?.getForecastDays()
                XCTAssertEqual(daysCount?.count, 3)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 10)
        
    }
}
