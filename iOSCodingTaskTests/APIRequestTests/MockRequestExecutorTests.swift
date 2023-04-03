//
//  MockURLProtocol.swift
//  iOSCodingTaskTests
//
//  Created by Ivan Vasilev on 4/1/23.
//

import XCTest
@testable import iOSCodingTask

class MockRequestExecutorTests: XCTestCase {
    
    private var requestExecutor: MockAPIClient?
    
    override func setUp() {
        super.setUp()
        
        let urlSession: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [MockURLProtocol.self]
            return URLSession(configuration: configuration)
        }()
        requestExecutor = MockAPIClient(session: urlSession)
    }
    
    override func tearDown() {
        super.tearDown()
        requestExecutor = nil
    }
    
    func test_StatusCode100To199_ResultIsProvisionalResponse() {
        let statusCode = Int.random(in: 100..<200)
        guard let url = URL(string: "http://127.0.0.1:8080"),
              let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil) else {
            XCTFail("Failed to prepare response")
            return
        }
        
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(response)
        let expectation = XCTestExpectation(description: "Perform a request")
        requestExecutor?.getRequest(endpoint: EndpointCase.getForecast.url, completionHandler: { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .provisionResponse)
                expectation.fulfill()
            default:
                XCTFail("Response failed")
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_StatusCode300To399_ResultIsRedirection() {
        let statusCode = Int.random(in: 300..<399)
        guard let url = URL(string: "http://127.0.0.1:8080"),
              let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil) else {
            XCTFail("Failed to prepare response")
            return
        }
        
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(response)
        let expectation = XCTestExpectation(description: "Perform a request")
        requestExecutor?.getRequest(endpoint: EndpointCase.getForecast.url, completionHandler: { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .redirection)
                expectation.fulfill()
            default:
                XCTFail("Response failed")
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_StatusCode400To499_ResultIsConnectivityError() {
        let statusCode = Int.random(in: 400..<499)
        guard let url = URL(string: "http://127.0.0.1:8080"),
              let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil) else {
            XCTFail("Failed to prepare response")
            return
        }
        
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(response)
        let expectation = XCTestExpectation(description: "Perform a request")
        requestExecutor?.getRequest(endpoint: EndpointCase.getForecast.url, completionHandler: { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .connectivityError)
                expectation.fulfill()
            default:
                XCTFail("Response failed")
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_StatusCode500To599_ResultIsServerError() {
        let statusCode = Int.random(in: 500..<599)
        guard let url = URL(string: "http://127.0.0.1:8080"),
              let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil) else {
            XCTFail("Failed to prepare response")
            return
        }
        
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(response)
        let expectation = XCTestExpectation(description: "Perform a request")
        requestExecutor?.getRequest(endpoint: EndpointCase.getForecast.url, completionHandler: { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .serverError)
                expectation.fulfill()
            default:
                XCTFail("Response failed")
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_StatusCode200To300_ResultIsSuccess() {
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
        
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(response)
        
        let expectation = XCTestExpectation(description: "Perform a request")
        requestExecutor?.getRequest(endpoint: EndpointCase.getForecast.url, completionHandler: { response in
            switch response {
            case .success(let success):
                XCTAssertEqual(success.forecast.forecastDay.count, 3)
                XCTAssertEqual(success.location.country, "United Kingdom")
                XCTAssertEqual(success.location.name, "London")
                expectation.fulfill()
            default:
                XCTFail()
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_BadResponse() {
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.error(.badResponse)
        
        let expectation = XCTestExpectation(description: "Perform a request")
        requestExecutor?.getRequest(endpoint: EndpointCase.getForecast.url, completionHandler: { response in
            switch response {
            case .failure(let error):
                XCTAssertEqual(error, .badResponse)
                expectation.fulfill()
            default:
                XCTFail("Response failed")
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 10)
    }
}
