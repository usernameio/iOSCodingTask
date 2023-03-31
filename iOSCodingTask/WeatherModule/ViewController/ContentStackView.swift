//
//  SectionOneView.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import UIKit

class ContentStackView: UIStackView {
    // MARK: - Properties
    private var cityStackView = CityStackView()
    private var forecastScrollView = ForecastScrollView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func configureView() {
        axis = .vertical
        distribution = .fillEqually
        alignment = .center
        backgroundColor = .systemYellow
        configureCitySection()
    }
    
    private func configureCitySection() {
        guard cityStackView.superview == nil else {
            return
        }
        
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
    
    /// Setup the content of the City where user is currently located
    /// - Parameters:
    ///   - country: country of the location
    ///   - city: city of the location
    ///   - localDateAndTime: local date and time
    func setupCityData(country: String, city: String, localDateAndTime: String) {
        cityStackView.setupText(country: country, city: city, localDateAndTime: localDateAndTime)
    }
    
    /// Setup the forecast data to display
    /// - Parameter data: data to display
    func setupForecastData(data: [DayModel]) {
        forecastScrollView.loadForecastData(forecast: data)
    }
}
