//
//  ForecastDayDTO.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

struct ForecastDayModel: DTOModel {
    // MARK: - Properties
    var date = String()
    var day = SingleDayModel()
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
    }
}
