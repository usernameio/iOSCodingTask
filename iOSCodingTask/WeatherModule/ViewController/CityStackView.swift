//
//  CityStackView.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import UIKit
import SwiftUI

class Observable<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        listener = closure
        listener?(value)
    }
}


class CityStackView: UIStackView {
    // MARK: - Properties
    private var countryTextView = UILabel()
    private var cityTextView = UILabel()
    private var localDateAndTimeTextView = UILabel()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        configureCityScreen(
            city: cityTextView,
            country: countryTextView,
            localTime: localDateAndTimeTextView
        )
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup the data provided from the server to fill the city Labels
    /// - Parameters:
    ///   - country: current country
    ///   - city: current city
    ///   - localTime: current date and time
    func setupLocationText(
        country: String,
        city: String,
        localTime: String
    ) {
        countryTextView.text = country
        countryTextView.font = .systemFont(ofSize: 20.0)
        cityTextView.text = city
        cityTextView.font = .systemFont(ofSize: 20.0)
        localDateAndTimeTextView.text = localTime
        localDateAndTimeTextView.font = .systemFont(ofSize: 20.0)
    }
}

extension CityStackView {
    
    func configureCityScreen(
        city: UILabel,
        country: UILabel,
        localTime: UILabel
    ) {
        guard city.superview == nil ||
                country.superview == nil ||
                localTime.superview == nil else {
            return
        }
        
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
}
