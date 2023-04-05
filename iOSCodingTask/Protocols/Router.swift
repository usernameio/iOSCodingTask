//
//  ApplicationCoordinator.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 4/4/23.
//

import UIKit

class Router: RouterProtocol {
    
    var navController: UINavigationController?
    var associations = [String: (WeatherViewModel) -> UIViewController]()
    
    init() {
        associations[getType(obj: WeatherViewModel.self)] = {
            model in WeatherViewController(viewModel: model)
        }
    }
    
    func push(viewModel: WeatherViewModel) {
        let vc: UIViewController = getController(viewModel)
        
        navController?.navigationBar.isHidden = true
        navController?.pushViewController(vc, animated: false)
    }
    
    func getController<T: WeatherViewModel>(_ viewModel: T) -> UIViewController {
        guard let controller = associations[getType(obj: WeatherViewModel.self)] else {
            fatalError("association not found")
        }
        return controller(viewModel)
    }
    
    func getType<T>(obj: T) -> String {
        return String(reflecting: obj)
    }
    
}
