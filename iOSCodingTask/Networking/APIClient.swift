//
//  APIClient.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol RequestExecutableProtocol: AnyObject {
    func getRequest(
        endpoint: String,
        completionHandler: @escaping (Result<WeatherModel, RequestError>) -> Void
    )
}

class APIClient: RequestExecutableProtocol {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    /// Triggers a call to server with pre-specified type of result (Generic) and endpoint)
    /// - Parameters:
    ///   - type: Generic Type
    ///   - endpoint: URL
    ///   - completionHandler: result of call
    func getRequest(
        endpoint: String,
        completionHandler: @escaping (Result<WeatherModel, RequestError>) -> Void
    ) {
        guard let url = URL(string: endpoint) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(.dataTaskError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(WeatherModel.self, from: data)
                completionHandler(.success(jsonData))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }.resume()
    }
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
