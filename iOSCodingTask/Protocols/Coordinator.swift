//
//  Coordinator.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 4/4/23.
//

import Foundation

protocol Coordinator {
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
