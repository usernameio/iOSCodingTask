//
//  SectionOneView.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import UIKit
import Combine

class ContentStackView: UIStackView {
    // MARK: - Properties
    private var weatherVM = WeatherViewModel(forecastRepository: ForecastRepository(requestExecutor: APIClient(session: URLSession.shared)))
    private var cancellables = Set<AnyCancellable>()
    private var cityStackView = CityStackView()
    private var forecastScrollView = ForecastScrollView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCitySection(
            cityStackView: cityStackView,
            forecastScrollView: forecastScrollView
        )
        fetchLocationData()
        loadWeatherData()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func fetchLocationData() {
        weatherVM.getWeatherData()
    }
    
    private func loadWeatherData() {
        self.weatherVM.$weatherModel.sink { model in
            self.cityStackView.setupLocationText(
                country: model.location.country,
                city: model.location.name,
                localTime: model.location.localtime
            )
            
            self.forecastScrollView.loadForecastData(forecast: model.forecast)
        }
        .store(in: &cancellables)
    }
}

extension ContentStackView {
    
    func configureCitySection(cityStackView: UIStackView, forecastScrollView: UIScrollView) {
        guard cityStackView.superview == nil,
              forecastScrollView.superview == nil else {
            return
        }
        
        axis = .vertical
        distribution = .fillEqually
        alignment = .center
        backgroundColor = .systemYellow
        
        forecastScrollView.backgroundColor = .systemGreen
        translatesAutoresizingMaskIntoConstraints = false
        cityStackView.translatesAutoresizingMaskIntoConstraints = false
        forecastScrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(forecastScrollView)
        addSubview(cityStackView)
        
        NSLayoutConstraint.activate([
            cityStackView.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 10),
            cityStackView.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -10),
            cityStackView.topAnchor
                .constraint(equalTo: topAnchor),
            cityStackView.bottomAnchor
                .constraint(equalTo: forecastScrollView.topAnchor),
            
            forecastScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            forecastScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            forecastScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            forecastScrollView.topAnchor.constraint(equalTo: cityStackView.bottomAnchor)
        ])
    }
}
