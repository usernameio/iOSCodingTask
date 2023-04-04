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
        configureForecastStackView(
            image: currentConditionImageView,
            minTempC: minTempC,
            maxTempC: maxTempC,
            date: date
        )
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    /// Setup the forecast for the upcoming days
    /// - Parameters:
    ///   - currentConditionImageView: url in String format to display weather icon
    ///   - minTempC: minimum temperature in Celsius for the particular day
    ///   - maxTempC: maximum temperature in Celsius for the particular day
    ///   - date: date the forecast is related to
    func setupSingleDayForecast(
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

extension ForecastStackView {
    
    func configureForecastStackView(
        image: UIImageView,
        minTempC: UILabel,
        maxTempC: UILabel,
        date: UILabel
    ) {
        guard image.superview == nil ||
        minTempC.superview == nil ||
        maxTempC.superview == nil ||
        date.superview == nil else {
            return
        }
        
        axis = .vertical
        
        translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        minTempC.translatesAutoresizingMaskIntoConstraints = false
        maxTempC.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        
        addArrangedSubview(image)
        addArrangedSubview(minTempC)
        addArrangedSubview(maxTempC)
        addArrangedSubview(date)
        
        NSLayoutConstraint.activate([
            image.heightAnchor
                .constraint(equalTo: minTempC.heightAnchor),
            maxTempC.heightAnchor
                .constraint(equalTo: date.heightAnchor),
            image.heightAnchor
                .constraint(equalTo: date.heightAnchor),
            
            
            image.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            minTempC.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            maxTempC.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            date.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            
            image.topAnchor
                .constraint(equalTo: topAnchor),
            minTempC.topAnchor
                .constraint(equalTo: image.bottomAnchor),
            maxTempC.topAnchor
                .constraint(equalTo: minTempC.bottomAnchor),
            date.bottomAnchor
                .constraint(equalTo: bottomAnchor)
        ])
    }
}
