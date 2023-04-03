//
//  RequestErrorTest.swift
//  iOSCodingTaskTests
//
//  Created by Ivan Vasilev on 3/31/23.
//

import XCTest
@testable import iOSCodingTask

final class RequestErrorTest: XCTestCase {
    
    func testRequestError() {
        let descriptions: [RequestError: String] = [
            .dataTaskError: "DataTask error.",
            .badResponse: "Empty Response.",
            .emptyData: "Empty Data.",
            .decodeError: "JSON could not be decoded.",
            .unknownError: "Something went wrong.",
            .provisionResponse: "Status codes that indicate a provisional response and require the requester to take action to continue. Please try to repeat operation or contact the support team",
            .redirection: "Server has several actions available based on the request. Please try to repeat operation or contact the support team",
            .connectivityError: "An error occurred related to connectivity. Please try to repeat operation or contact the support team",
            .serverError: "Server had an internal error when trying to process the request. Please try to repeat operation or contact the support team"
        ]
        RequestError.allCases.forEach { XCTAssertEqual($0.title, descriptions[$0]) }
    }
}
