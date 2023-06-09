//
//  Coordinator.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 4/4/23.
//

import Foundation

protocol RouterProtocol {
    func push(viewModel: WeatherViewModel)
}

protocol RoutingProtocol {
    var coordinator: RouterProtocol? { get set }
}
