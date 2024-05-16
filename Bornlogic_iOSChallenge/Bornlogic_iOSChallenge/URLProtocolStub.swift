//
//  URLProtocolMock.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 16/05/2024.
//

import Foundation

class URLProtocolStub: URLProtocol {
    static var response: HTTPURLResponse?
    static var responseData: Data?
    static var error: Error?
    
    static func setupStubSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        return URLSession(configuration: configuration)
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocol(self, didLoad: URLProtocolStub.responseData ?? Data())
            if let response = URLProtocolStub.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
    }
}
