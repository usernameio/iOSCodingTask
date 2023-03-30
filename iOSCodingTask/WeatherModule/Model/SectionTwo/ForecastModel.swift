//
//  ForecastModel.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/30/23.
//

import Foundation

class ForecastModel: WeatherProtocol {
    // MARK: - Properties
    private var sevenDaysForecast = [DayModel]()
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
            sevenDaysForecast.append(day)
        }
    }
    
    /// Triggers a request to get the forecast
    /// - Parameter completion: return result of type WeatherDTO
    func getWeatherData() {
        apiClient?.getRequest(
            type: WeatherDTO.self,
            endpoint: .getForecast
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let forecast):
                    self.setupForecast(data: forecast)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}
