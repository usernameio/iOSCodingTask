//
//  WeatherViewController.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    private var forecastStackView = ContentStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupContentView(contentView: forecastStackView)
    }
    
}

extension UIViewController {
    
    func setupContentView(contentView: UIView) {
        guard contentView.superview == nil else {
            return
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
    }
}
