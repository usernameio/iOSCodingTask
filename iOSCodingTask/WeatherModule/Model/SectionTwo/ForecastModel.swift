//
//  ForecastModel.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import Foundation

class ForecastModel: WeatherProtocol {
    // MARK: - Properties
    private var forecast = [DayModel]()
    private var apiClient: APIClient? = ServiceLocator.shared.getService()
    
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
    /// - Parameter completion: return VOID
    func getWeatherData(completion: @escaping (Result<Void, APIClient.RequestError>) -> Void) {
        apiClient?.getRequest(
            type: WeatherDTO.self,
            endpoint: .getForecast
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let forecast):
                    self?.setupForecast(data: forecast)
                    completion(.success(()))
                case .failure(let failure):
                    print(failure.title)
                }
            }
        }
    }
    
    /// Provides forecast
    /// - Returns: returns an array of DayModel to provides data for forecast
    func getForecastData() -> [DayModel] {
        forecast
    }
}
