//
//  ForecastScrollView.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import UIKit

class TableeeeeeView: UITableView {
    
}




class ForecastScrollView: UIScrollView {
    // MARK: - Properties
    private var scrollContainer = UIView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addScrollContainer(view: scrollContainer)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Builds each day of the forecast with the proper data from server
    /// - Parameter forecast: data converted into Days and ready to be set in a stackView
    func loadForecastData(
        forecast: ForecastForThreeDaysModel
    ) {
        let stackViewToShow = UIStackView()
        stackViewToShow.axis = .vertical
        stackViewToShow.alignment = .center
        stackViewToShow.translatesAutoresizingMaskIntoConstraints = false
        
        for index in 0..<forecast.forecastDay.count {
            let sampleDay = forecast.forecastDay[index]
            let foreCastStackView = ForecastStackView()
            foreCastStackView.setupSingleDayForecast(
                currentConditionImageView: sampleDay.day.condition.icon,
                minTempC: sampleDay.day.minTempC,
                maxTempC: sampleDay.day.maxTempC,
                date: sampleDay.date
            )
            stackViewToShow.addArrangedSubview(foreCastStackView)
        }
        addSubview(stackViewToShow)
    }
}

extension ForecastScrollView {
    
    func addScrollContainer(view: UIView) {
        guard view.superview == nil else {
            return
        }
        
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
}
