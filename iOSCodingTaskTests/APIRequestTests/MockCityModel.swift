////
////  MockCityModel.swift
////  iOSCodingTaskTests
////
////  Created by Ivan Vasilev on 4/1/23.
////
//
//import Foundation
//@testable import iOSCodingTask
//
//class MockCityModel: WeatherProtocol {
//    
//    // MARK: - Properties
//    var country: String?
//    var name: String?
//    var localDateTime: String?
//    private var requestExecutableProtocol: RequestExecutableProtocol
//    
//    // MARK: - Initializers
//    init(
//        country: String? = nil,
//        name: String? = nil,
//        localDateTime: String? = nil,
//        requestExecutableProtocol: RequestExecutableProtocol
//    ) {
//        self.country = country
//        self.name = name
//        self.localDateTime = localDateTime
//        self.requestExecutableProtocol = requestExecutableProtocol
//    }
//    
//    
//    func getWeatherData(
//        completion: @escaping (Result<Void, iOSCodingTask.RequestError>) -> Void) {
//            requestExecutableProtocol.getRequest(
//                endpoint: EndpointCase.getForecast.url) { response in
//                    switch response {
//                    case .success(let success):
//                        completion(.success(()))
//                    case .failure(let failure):
//                        completion(.failure(failure))
//                    }
//                }
//        }
//    
//}
