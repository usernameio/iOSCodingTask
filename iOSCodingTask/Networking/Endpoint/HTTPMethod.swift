//
//  HTTPMethod.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/31/23.
//

import Foundation

enum HTTPMethod: CaseIterable {
    
    case get
    
    var method: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}
