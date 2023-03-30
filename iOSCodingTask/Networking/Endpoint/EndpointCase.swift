//
//  EndpointCase.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

enum EndpointCase {
    
    case getForecast
    
    var url: String {
        switch self {
        case .getForecast:
            return
            "http://api.weatherapi.com/v1/forecast.json?key=522db6a157a748e2996212343221502&q=London&days=7&aqi=no&alerts=no"
        }
    }
}
