//
//  NewsServiceTests.swift
//  Bornlogic_iOSChallengeTests
//
//  Created by Guilherme Viana on 16/05/2024.
//

import XCTest

@testable import Bornlogic_iOSChallenge

class NewsServiceTests: XCTestCase {
    var session: URLSession!
    var service: NewsService!

    override func setUp() {
        super.setUp()
        session = URLProtocolStub.setupStubSession()
        service = NewsService(session: session)
    }

    override func tearDown() {
        super.tearDown()
        URLProtocolStub.response = nil
        URLProtocolStub.responseData = nil
        URLProtocolStub.error = nil
        session = nil
        service = nil
    }

    func testFetchData_Success_ShouldReturnData() async throws {
        guard let validJSONData = loadTestData() else {
            XCTFail("Failed to load valid JSON data")
            return
        }
                
        URLProtocolStub.response = HTTPURLResponse(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=47254af115e34999a5a86b9519eed9b4")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        URLProtocolStub.responseData = validJSONData
        
        do {
            let data = try await service.fetchData(for: .topHeadlines, country: .unitedStates, category: .entertainment)
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertEqual(data?.articles.first?.author, "Eric Todisco")
            XCTAssertEqual(data?.articles.first?.urlToImage, "https://nypost.com/wp-content/uploads/sites/2/2024/05/81908277.jpg?quality=75&strip=all&w=1024")
            XCTAssertEqual(data?.articles.first?.title, "Gavin Newsom reacts to Meghan, Harry's 'delinquent' charity - New York Post ")
            XCTAssertEqual(data?.articles.first?.description, "Gavin Newsom spoke out about Meghan Markle and Prince Harry’s “celebrated” foundation after it was temporarily declared “delinquent” by California’s attorney general.…")
            XCTAssertEqual(data?.articles.first?.content, "California Governor Gavin Newsom weighed in on the controversy surrounding Prince Harry and Meghan Markle’s Archewell Foundation.\r\nThe charity run by the couple was declared “delinquent and ordered t… [+3709 chars]")
        } catch {
            XCTFail("Expected successful data fetch but received an error: \(error)")
        }
    }
    
    func testFetchData_Failure_ShouldThrowInvalidURLError() async throws {        
        do {
            _ = try await service.fetchData(for: nil, country: nil, category: nil)
            XCTFail("Expected failure due to invalid URL but received data")
        } catch let error as NewsError {
            XCTAssertEqual(error, NewsError.invalidURL)
        } catch {
            XCTFail("Expected invalidURL error but received different error: \(error)")
        }
    }
    
    func testFetchData_Failure_ShouldThrowInvalidResponseError() async throws {
        URLProtocolStub.response = HTTPURLResponse(url: URL(string: "https://newsapi.org")!,
                                                   statusCode: 404,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        URLProtocolStub.responseData = nil
        
        do {
            _ = try await service.fetchData(for: .topHeadlines, country: .unitedStates, category: .entertainment)
            XCTFail("Expected failure due to invalid response but succeeded")
        } catch let error as NewsError {
            XCTAssertEqual(error, NewsError.invalidResponse)
        } catch {
            XCTFail("Expected invalidResponse error but received different error: \(error)")
        }
    }
    
    func testFetchData_Failure_ShouldThrowInvalidDataError() async throws {
        let invalidJSONData = "invalid data".data(using: .utf8)
        
        URLProtocolStub.response = HTTPURLResponse(url: URL(string: "https://newsapi.org")!,
                                                   statusCode: 200,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        URLProtocolStub.responseData = invalidJSONData
        
        do {
            _ = try await service.fetchData(for: .topHeadlines, country: .unitedStates, category: .entertainment)
            XCTFail("Expected failure due to data error but succeeded")
        } catch let error as NewsError {
            XCTAssertEqual(error, NewsError.invalidData)
        } catch {
            XCTFail("Expected invalidData error but received different error: \(error)")
        }
    }
    
    func testFetchImage_Success_ShouldReturnImage() async {
        let imageService = ImageService()
        
        let image = await imageService.downloadImageAsync(from: "https://nypost.com/wp-content/uploads/sites/2/2024/05/81908277.jpg?quality=75&strip=all&w=1024")
        
        XCTAssertNotNil(image, "Image should not be nil")
    }
    
}

extension NewsServiceTests {
    private func loadTestData() -> Data? {
        guard let url = Bundle(for: type(of: self)).url(forResource: "ValidNewsDataJSON", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("Error loading test data file")
            return nil
        }
        return data
    }
}
