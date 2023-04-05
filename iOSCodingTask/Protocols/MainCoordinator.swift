//
//  ApplicationCoordinator.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 4/4/23.
//
 
import UIKit
 
class MainCoordinator: Coordinator {
    
    var navController: UINavigationController?
    func start() {
        var vc: UIViewController & Coordinating = WeatherViewController()
        vc.coordinator = self
            
        navController?.navigationBar.isHidden = true
        navController?.setViewControllers([vc], animated: false)
    }
} 
