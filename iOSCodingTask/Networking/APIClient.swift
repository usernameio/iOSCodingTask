//
//  APIClient.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/29/23.
//

import Foundation

protocol WeatherProtocol {
    func getWeatherData(completion: @escaping (Result<Void, APIClient.RequestError>) -> Void)
}

struct APIClient {
    //MARK: - Properties
    enum RequestError: Error {
        case dataTaskError
        case badResponse
        case emptyData
        case decodeError
        case unknownError
        
        var title: String {
            switch self {
            case .dataTaskError: return "DataTask error."
            case .badResponse: return "Empty Response."
            case .emptyData: return "Empty Data."
            case .decodeError: return "JSON could not be decoded."
            case .unknownError: return "Something went wrong."
            }
        }
    }
    
    /// Triggers a call to server with pre-specified type of result (Generic) and endpoint)
    /// - Parameters:
    ///   - type: Generic Type
    ///   - endpoint: URL
    ///   - completionHandler: result of call
    func getRequest<U: Codable>(
        type: U.Type = U.self,
        endpoint: EndpointCase,
        completionHandler: @escaping (Result<U, RequestError>) -> Void
    ) {
        guard let url = URL(string: endpoint.url) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                let jsonData = try decoder.decode(U.self, from: data)
                completionHandler(.success(jsonData)) 
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }.resume()
    }
}
