//
//  CityModel.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

protocol WeatherProtocol {
    func getWeatherData(completion: @escaping (Result<Void, RequestError>) -> Void)
}

class CityModel: WeatherProtocol {
    // MARK: - Properties
    var country: String?
    var name: String?
    var localDateTime: String?
    private var requestExecutableProtocol: RequestExecutableProtocol
    
    // MARK: - Initializers
    init(
        country: String? = nil,
        name: String? = nil,
        localDateTime: String? = nil,
        requestExecutableProtocol: RequestExecutableProtocol
    ) {
        self.country = country
        self.name = name
        self.localDateTime = localDateTime
        self.requestExecutableProtocol = requestExecutableProtocol
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
    func getWeatherData(completion: @escaping (Result<Void, RequestError>) -> Void) {
        requestExecutableProtocol.getRequest(endpoint: EndpointCase.getForecast.url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.setupCity(data: data)
                    completion(.success(()))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
    
}
