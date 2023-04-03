//
//  MockableResponse.swift
//  iOSCodingTaskTests
//
//  Created by Ivan Vasilev on 3/31/23.
//

import Foundation
@testable import iOSCodingTask

protocol MockableResponse: AnyObject {
    var bundle: Bundle { get }
    
    func loadJSON<T: Codable>(filename: String, modelType: T.Type) throws -> T
}

extension MockableResponse {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    /// Prepares the json file for usage
    /// - Parameters:
    ///   - filename: name of the json file in project
    ///   - modelType: the model type of the json file
    /// - Returns: returns an array of items or an error
    func loadJSON<T: Decodable>(
        filename: String,
        modelType: T.Type
    ) throws -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            throw RequestError.unknownError
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            
            return decodedObject
        } catch {
            throw RequestError.decodeError
        }
    }
}
