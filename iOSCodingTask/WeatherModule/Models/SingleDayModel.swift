//
//  DayDTO.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

struct SingleDayModel: DTOModel {
    // MARK: - Properties
    var condition = ConditionModel()
    var minTempC = Double()
    var maxTempC = Double()
    
    enum CodingKeys: String, CodingKey {
        case condition
        case minTempC = "mintemp_c"
        case maxTempC = "maxtemp_c"
    }
}
