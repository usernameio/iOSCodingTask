//
//  MockURLProtocol.swift
//  iOSCodingTaskTests
//
//  Created by Ivan Vasilev on 4/2/23.
//

import XCTest
@testable import iOSCodingTask

final class MockURLProtocol: URLProtocol {
    
    enum ResponseType {
        case error(RequestError)
        case success(HTTPURLResponse)
    }
    
    static var responseType: ResponseType?
    private(set) var activeTask: URLSessionTask?
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let urlRequest = request.url else {
            fatalError("Encountered error in urlRequest")
        }
        activeTask = session.dataTask(with: urlRequest)
        activeTask?.cancel()
    }
    
    override func stopLoading() {
        activeTask?.cancel()
    }
}

// MARK: - URLSessionDataDelegate
extension MockURLProtocol: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        switch MockURLProtocol.responseType {
        case .error(let error):
            client?.urlProtocol(self, didFailWithError: error)
        case .success(let response):
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        default: break
        }
        client?.urlProtocolDidFinishLoading(self)
    }
}
