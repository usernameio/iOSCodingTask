//
//  RequestError.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/31/23.
//

import Foundation

enum RequestError: Error, CaseIterable {
    case dataTaskError
    case badResponse
    case emptyData
    case decodeError
    case unknownError
    case provisionResponse
    case redirection
    case connectivityError
    case serverError
    
    var title: String {
        switch self {
        case .dataTaskError: return "DataTask error."
        case .badResponse: return "Empty Response."
        case .emptyData: return "Empty Data."
        case .decodeError: return "JSON could not be decoded."
        case .unknownError: return "Something went wrong."
        case .provisionResponse: return "Status codes that indicate a provisional response and require the requester to take action to continue. Please try to repeat operation or contact the support team"
        case .redirection:
            return "Server has several actions available based on the request. Please try to repeat operation or contact the support team"
        case .connectivityError:
            return "An error occurred related to connectivity. Please try to repeat operation or contact the support team"
        case .serverError:
            return "Server had an internal error when trying to process the request. Please try to repeat operation or contact the support team"
        }
    }
}
