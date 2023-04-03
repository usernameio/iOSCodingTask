//
//  ListOfJSONFileNames.swift
//  iOSCodingTaskTests
//
//  Created by Ivan Vasilev on 3/31/23.
//

import Foundation

enum ListOfJSONFileNames: String {
    case forecast = "WeatherForecast"
    
    var jsonFileName: String {
        switch self {
        case .forecast:
            return "WeatherForecast"
        }
    }
}
