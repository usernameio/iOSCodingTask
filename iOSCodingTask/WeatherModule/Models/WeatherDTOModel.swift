//
//  WeatherDTO.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

typealias DTOModel = Codable

struct WeatherModel: DTOModel {
    // MARK: - Properties
    var location = LocationModel()
    var current = CurrentModel()
    var forecast = ForecastForThreeDaysModel()
}
