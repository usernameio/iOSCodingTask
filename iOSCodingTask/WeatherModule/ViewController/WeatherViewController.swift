//
//  ViewController.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import UIKit

class WeatherViewController: UIViewController {
    // MARK: - Properties
    private var cityModel = CityModel()
    private var forecastModel = ForecastModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen() 
    }
    
    // MARK: - Methods
    private func setupScreen() {
        cityModel.getWeatherData()
        forecastModel.getWeatherData()
    }
}
