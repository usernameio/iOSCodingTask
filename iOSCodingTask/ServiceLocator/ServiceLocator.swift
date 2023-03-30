//
//  ServiceLocator.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation
import UIKit

protocol ServiceLocating {
    func getService<T>() -> T?
}

final class ServiceLocator: ServiceLocating {
    private lazy var services: Dictionary<String, Any> = [:]
    
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(some.self)"
    }
    
    /// New service is added.
    /// - Parameter service: type of service
    func addService<T>(service: T) {
        let key = typeName(some: T.self)
        services[key] = service
    }
    
    /// Provides the service of specific type.
    /// - Returns: type of service
    func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
    
    public static let shared = ServiceLocator()
}

