//
//  ForecastDTO.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

struct ForecastDTO: Codable {
    // MARK: - Properties
    let forecastDay: [ForecastDayDTO]
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    } 
}
