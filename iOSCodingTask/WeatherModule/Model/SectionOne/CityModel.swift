//
//  CityModel.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

class CityModel: WeatherProtocol {
    // MARK: - Properties
    var country: String?
    var name: String?
    var localDateTime: String?
    private var apiClient: APIClient? = ServiceLocator.shared.getService()
    
    // MARK: - Initializers
    init(country: String? = nil, name: String? = nil, localDateTime: String? = nil) {
        self.country = country
        self.name = name
        self.localDateTime = localDateTime
    }
    
    // MARK: - Methods
    private func setupCity(data: WeatherDTO) {
        let currentLocation = data.location
        self.country = currentLocation.country
        self.name = currentLocation.name
        self.localDateTime = currentLocation.localtime
    }
    
    /// Triggers a request to get the forecast
    /// - Parameter completion: returns Void
    func getWeatherData(completion: @escaping (Result<Void, APIClient.RequestError>) -> Void) {
        apiClient?.getRequest(
            type: WeatherDTO.self,
            endpoint: .getForecast
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.setupCity(data: data)
                    completion(.success(()))
                case .failure(let failure):
                    print(failure.title)
                }
            }
        }
    }
    
}
