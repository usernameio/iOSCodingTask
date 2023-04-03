//
//  HTTPMethodTest.swift
//  iOSCodingTaskTests
//
//  Created by Ivan Vasilev on 3/31/23.
//

import XCTest
@testable import iOSCodingTask

final class HTTPMethodTest: XCTestCase {

    func testHTTPMethod() {
        let descriptions: [HTTPMethod: String] = [
            .get: "GET"
        ]

        HTTPMethod.allCases.forEach { XCTAssertEqual($0.method, descriptions[$0]) }
    }

}
