//
//  WeatherDTO.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

struct WeatherDTO: Codable {
    // MARK: - Properties
    let location: LocationDTO
    let current: CurrentDTO
    let forecast: ForecastDTO 
}