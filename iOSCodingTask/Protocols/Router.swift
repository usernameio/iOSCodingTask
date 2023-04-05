//
//  ApplicationCoordinator.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 4/4/23.
//
 
import UIKit
 
class Router: RouterProtocol {
    
    var navController: UINavigationController?
    
    func start() {
        let vc: UIViewController = WeatherViewController(viewModel: BaseViewModel(router: self)) 
                    
        navController?.navigationBar.isHidden = true
        navController?.setViewControllers([vc], animated: false)
    }
} 
