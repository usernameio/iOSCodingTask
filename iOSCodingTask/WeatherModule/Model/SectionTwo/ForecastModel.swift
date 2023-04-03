//
//  ForecastModel.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import Foundation

class ForecastModel: WeatherProtocol {
    // MARK: - Properties
    var forecast = [DayModel]()
    var requestExecutableProtocol: RequestExecutableProtocol
    
    // MARK: - Initializers
    init(
        requestExecutableProtocol: RequestExecutableProtocol
    ) {
        self.requestExecutableProtocol = requestExecutableProtocol
    }
    
    // MARK: - Methods
    private func setupForecast(data: WeatherDTO) {
        for sampleDay in data.forecast.forecastDay {
            let day = DayModel(
                icon: sampleDay.day.condition.icon,
                minTempC: sampleDay.day.minTempC,
                maxTempC: sampleDay.day.maxTempC,
                date: sampleDay.date
            )
            forecast.append(day)
        }
    }
    
    /// Triggers a request to get the forecast
    /// - Parameter completion: return Void
    func getWeatherData(completion: @escaping (Result<Void, RequestError>) -> Void) {
        requestExecutableProtocol.getRequest(endpoint: EndpointCase.getForecast.url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let forecast):
                    self?.setupForecast(data: forecast)
                    completion(.success(()))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
    
    /// Provides forecast
    /// - Returns: returns an array of DayModel to provides data for forecast
    func getForecastDays() -> [DayModel] {
        forecast
    }
}
