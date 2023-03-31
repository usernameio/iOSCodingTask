//
//  ForecastScrollView.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import UIKit

class ForecastScrollView: UIScrollView {
    // MARK: - Properties
    private var scrollContainer = UIView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        scrollContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollContainer.backgroundColor = .systemGreen
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollContainer)
        
        let scrollContentGuide = self.contentLayoutGuide
        let scrollFrameGuide = self.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollContainer.leadingAnchor
                .constraint(equalTo: scrollContentGuide.leadingAnchor),
            scrollContainer.trailingAnchor
                .constraint(equalTo: scrollContentGuide.trailingAnchor),
            scrollContainer.topAnchor
                .constraint(equalTo: scrollContentGuide.topAnchor),
            scrollContainer.bottomAnchor
                .constraint(equalTo: scrollContentGuide.bottomAnchor),
            
            scrollContainer.leadingAnchor
                .constraint(equalTo: scrollFrameGuide.leadingAnchor),
            scrollContainer.trailingAnchor
                .constraint(equalTo: scrollFrameGuide.trailingAnchor),
            scrollContainer.heightAnchor
                .constraint(equalToConstant: 2200)
        ])
    }
    
    /// Builds each day of the forecast with the proper data from server
    /// - Parameter forecast: data converted into Days and ready to be set in a stackView
    func loadForecastData(
        forecast: [DayModel]
    ) {
        let stackViewToShow = UIStackView()
        stackViewToShow.axis = .vertical
        stackViewToShow.alignment = .center
        stackViewToShow.translatesAutoresizingMaskIntoConstraints = false
        
        for index in 0..<forecast.count {
            let sampleDay = forecast[index]
            let foreCastStackView = ForecastStackView()
            foreCastStackView.setForecast(
                currentConditionImageView: sampleDay.icon ?? String(),
                minTempC: sampleDay.minTempC ?? Double(),
                maxTempC: sampleDay.maxTempC ?? Double(),
                date: sampleDay.date ?? String()
            )
            stackViewToShow.addArrangedSubview(foreCastStackView)
        }
        addSubview(stackViewToShow)
    }
}
