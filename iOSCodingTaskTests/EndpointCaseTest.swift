//
//  iOSCodingTaskTests.swift
//  iOSCodingTaskTests
//
//  Created by Ivan Vasilev on 3/31/23.
//

import XCTest
@testable import iOSCodingTask

final class EndpointCaseTests: XCTestCase {

    func testEndpoint() {
        let descriptions: [EndpointCase: String] = [
            .getForecast: "http://api.weatherapi.com/v1/forecast.json?key=522db6a157a748e2996212343221502&q=Madrid&days=7&aqi=no&alerts=no"
        ]

        EndpointCase.allCases.forEach { XCTAssertEqual($0.url, descriptions[$0]) }
    }

}
