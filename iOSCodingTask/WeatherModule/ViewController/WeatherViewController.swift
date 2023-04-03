//
//  WeatherViewController.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    private var cityModel = CityModel(requestExecutableProtocol: APIClient(session: URLSession.shared))
    private var forecastModel = ForecastModel(requestExecutableProtocol: APIClient(session: URLSession.shared))
    private var contentStackView = ContentStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentView()
        getCityData()
        getForecast()
    }
    
    // MARK: - Methods
    private func getForecast() {
        forecastModel.getWeatherData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success( _):
                    self?.contentStackView.setupForecastData(
                        data: self?.forecastModel.getForecastDays() ?? [DayModel]()
                    )
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getCityData() {
        cityModel.getWeatherData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success( _):
                    self?.contentStackView.setupCityData(
                        country: self?.cityModel.country ?? String(),
                        city: self?.cityModel.name ?? String(),
                        localDateAndTime: self?.cityModel.localDateTime ?? String()
                    )
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func setupContentView() {
        view.backgroundColor = .white
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            contentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
    }
}
