//
//  NewsServiceTests.swift
//  Bornlogic_iOSChallengeTests
//
//  Created by Guilherme Viana on 16/05/2024.
//

import XCTest

@testable import Bornlogic_iOSChallenge

class NewsServiceTests: XCTestCase {
    var serviceMock: NewsServiceMock!

    override func setUp() {
        serviceMock = NewsServiceMock()
    }

    override func tearDown() {
        serviceMock = nil
    }
    
    func loadTestData() -> Data? {
        guard let url = Bundle(for: type(of: self)).url(forResource: "ValidNewsData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("Error loading test data file")
            return nil
        }
        return data
    }

    func testFetchData_Success_ShouldReturnData() async throws {
        let session = URLProtocolStub.setupStubSession()
        let service = NewsService(session: session)
        guard let validJSONData = loadTestData() else {
            XCTFail("Failed to load valid JSON data")
            return
        }
                
        URLProtocolStub.responseData = validJSONData
        URLProtocolStub.response = HTTPURLResponse(url: URL(string: "https://newsapi.org")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        do {
            let data = try await service.fetchData(for: .topHeadlines, country: .unitedStates, category: .entertainment)
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertEqual(data?.articles.first?.author, "Eric Todisco", "Title should match")
        } catch {
            XCTFail("Expected successful data fetch but received an error: \(error)")
        }
    }
    
    func testFetchData_Failure_ShouldReturnInvalidData() async throws {
        URLProtocolStub.responseData = nil
        URLProtocolStub.response = nil
        
        let session = URLProtocolStub.setupStubSession()
        let service = NewsService(session: session)
        
        do {
            _ = try await service.fetchData(for: .topHeadlines, country: .unitedStates, category: .entertainment)
            XCTFail("Expected failure due to invalid URL but received data")
        } catch NewsError.invalidURL {
        } catch {
            XCTFail("Expected invalidURL error but received different error: \(error)")
        }
    }
    
}
