//
//  ForecastDTO.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

struct ForecastForThreeDaysModel: DTOModel {
    // MARK: - Properties
    var forecastDay = [ForecastDayModel]()
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}
