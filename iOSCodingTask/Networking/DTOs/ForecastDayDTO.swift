//
//  ForecastDayDTO.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

struct ForecastDayDTO: DTOModel {
    // MARK: - Properties
    var date: String
    var day: DayDTO
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
    } 
}
