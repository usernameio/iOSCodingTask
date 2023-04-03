//
//  CityStackView.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import UIKit

class CityStackView: UIStackView {
    // MARK: - Properties
    private var countryTextView = UILabel()
    private var cityTextView = UILabel()
    private var localDateAndTimeTextView = UILabel()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCityScreen()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func configureCityScreen() {
        axis = .vertical
        alignment = .center
        
        translatesAutoresizingMaskIntoConstraints = false
        countryTextView.translatesAutoresizingMaskIntoConstraints = false
        cityTextView.translatesAutoresizingMaskIntoConstraints = false
        localDateAndTimeTextView.translatesAutoresizingMaskIntoConstraints = false
        
        addArrangedSubview(countryTextView)
        addArrangedSubview(cityTextView)
        addArrangedSubview(localDateAndTimeTextView)
        
        NSLayoutConstraint.activate([
            countryTextView.heightAnchor.constraint(equalTo: cityTextView.heightAnchor),
            localDateAndTimeTextView.heightAnchor.constraint(equalTo: countryTextView.heightAnchor),
            
            countryTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            localDateAndTimeTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            countryTextView.topAnchor.constraint(equalTo: topAnchor),
            localDateAndTimeTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    /// Setup content for UITextField after the data is fetched
    /// - Parameters:
    ///   - country: country of the current location
    ///   - city: city of current location
    ///   - localDateAndTime: current location local time and date
    func setupText(country: String, city: String, localDateAndTime: String) {
        countryTextView.text = country
        countryTextView.font = .systemFont(ofSize: 20.0)
        cityTextView.text = city
        cityTextView.font = .systemFont(ofSize: 20.0)
        localDateAndTimeTextView.text = localDateAndTime
        localDateAndTimeTextView.font = .systemFont(ofSize: 20.0)
    }
}
