//
//  ForecastStackView.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import UIKit

class ForecastStackView: UIStackView {
    // MARK: - Properties
    private var currentConditionImageView = UIImageView()
    private var minTempC = UILabel()
    private var maxTempC = UILabel()
    private var date = UILabel()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureForecastStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func configureForecastStackView() {
        axis = .vertical
        
        translatesAutoresizingMaskIntoConstraints = false
        currentConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        minTempC.translatesAutoresizingMaskIntoConstraints = false
        maxTempC.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
         
        addArrangedSubview(currentConditionImageView)
        addArrangedSubview(minTempC)
        addArrangedSubview(maxTempC)
        addArrangedSubview(date)
        
        NSLayoutConstraint.activate([
            currentConditionImageView.heightAnchor
                .constraint(equalTo: minTempC.heightAnchor),
            maxTempC.heightAnchor
                .constraint(equalTo: date.heightAnchor),
            currentConditionImageView.heightAnchor
                .constraint(equalTo: date.heightAnchor),
            
            
            currentConditionImageView.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            minTempC.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            maxTempC.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            date.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            
            currentConditionImageView.topAnchor
                .constraint(equalTo: topAnchor),
            minTempC.topAnchor
                .constraint(equalTo: currentConditionImageView.bottomAnchor),
            maxTempC.topAnchor
                .constraint(equalTo: minTempC.bottomAnchor),
            date.bottomAnchor
                .constraint(equalTo: bottomAnchor)
        ])
    }
    
    /// Setup the forecast for the upcoming days
    /// - Parameters:
    ///   - currentConditionImageView: url in String format to display weather icon
    ///   - minTempC: minimum temperature in Celsius for the particular day
    ///   - maxTempC: maximum temperature in Celsius for the particular day
    ///   - date: date the forecast is related to
    func setForecast(
        currentConditionImageView: String,
        minTempC: Double,
        maxTempC: Double,
        date: String
    ) {
        self.currentConditionImageView.load(urlString: currentConditionImageView)
        self.minTempC.text = String(format: "%.1f", minTempC)
        self.maxTempC.text = String(format: "%.1f", maxTempC)
        self.date.text = date
    }
    
}
