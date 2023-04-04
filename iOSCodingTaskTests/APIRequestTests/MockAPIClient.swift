//
//  File.swift
//  iOSCodingTaskTests
//
//  Created by Ivan Vasilev on 4/1/23.
//

import Foundation
@testable import iOSCodingTask

class MockAPIClient: RequestExecutableProtocol, MockableResponse {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getRequest(
        endpoint: String,
        completionHandler: @escaping (Result<iOSCodingTask.WeatherModel, iOSCodingTask.RequestError>) -> Void) {
            
            guard let url = URL(string: endpoint) else {
                return completionHandler(.failure(.decodeError))
            }
            let request = URLRequest(url: url)
            
            session.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    completionHandler(.failure(.badResponse))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(.failure(.badResponse))
                    return
                }
                
                switch response.statusCode {
                case 100...199:
                    completionHandler(.failure(.provisionResponse))
                    return
                case 300...399:
                    completionHandler(.failure(.redirection))
                    return
                case 400...499:
                    completionHandler(.failure(.connectivityError))
                    return
                case 500...599:
                    completionHandler(.failure(.serverError))
                    return
                default:
                    let fileName = ListOfJSONFileNames.forecast.jsonFileName
                    do {
                        let loadJson = try self.loadJSON(filename: fileName, modelType: WeatherModel.self)
                        completionHandler(.success(loadJson))
                    } catch {
                        completionHandler(.failure(.badResponse))
                    }
                }
            }.resume()
        }
}
