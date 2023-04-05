//
//  ForecastRepository.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 4/5/23.
//

import Foundation

class ForecastRepository {
    //MARK: Properties
    var requestExecutor: RequestExecutableProtocol
    
    //MARK: Initializer
    init(requestExecutor: RequestExecutableProtocol) {
        self.requestExecutor = requestExecutor
    }
    
    //MARK: Method
    /// Trigger a request to APIClient
    /// - Parameters:
    ///   - urlString: url that will be used for the request
    ///   - completion: completion with RequestError and WeatherModel as Result
    func execute(
        urlString: String,
        completion: @escaping (Result<WeatherModel, RequestError>) -> Void) {
            requestExecutor.getRequest(
                endpoint: urlString,
                completionHandler: completion
            )
        }
}
