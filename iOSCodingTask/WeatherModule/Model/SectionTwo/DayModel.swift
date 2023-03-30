//
//  DayModel.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

class DayModel {
    // MARK: - Properties
    var icon: String?
    var minTempC: Double?
    var maxTempC: Double?
    var date: String?
    
    // MARK: - Initializer
    init(
        icon: String? = nil,
        minTempC: Double? = nil,
        maxTempC: Double? = nil,
        date: String? = nil
    ) {
        self.icon = icon
        self.minTempC = minTempC
        self.maxTempC = maxTempC
        self.date = date
    }
    
}
