//
//  WeatherViewModel.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 4/4/23.
//

import Foundation
import Combine

protocol WeatherProtocol: AnyObject {
    func getWeatherData()
}

class WeatherViewModel: WeatherProtocol {
    //MARK: Properties
    @Published var weatherModel = WeatherModel()
    var requestExecutableProtocol: RequestExecutableProtocol
    
    //MARK: Initializers
    init(
        requestExecutableProtocol: RequestExecutableProtocol
    ) {
        self.requestExecutableProtocol = requestExecutableProtocol
    }
    
    //MARK: Methods
    private func setupWeather(data: WeatherModel) {
        weatherModel.location.name = data.location.name
        weatherModel.location.country = data.location.country
        weatherModel.location.localtime = data.location.localtime
        
        for currentDay in data.forecast.forecastDay {
            let nextDay = ForecastDayModel(
                date: currentDay.date,
                day: SingleDayModel(condition: currentDay.day.condition,
                                    minTempC: currentDay.day.minTempC,
                                    maxTempC: currentDay.day.maxTempC)
            )
            weatherModel.forecast.forecastDay.append(nextDay)
        }
    }
    
    /// Triggers a request to server to fetch data
    func getWeatherData() {
        requestExecutableProtocol.getRequest(endpoint: EndpointCase.getForecast.url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.setupWeather(data: data)
                case .failure(let failure):
                    print(failure.title)
                }
            }
        }
    }
    
}

