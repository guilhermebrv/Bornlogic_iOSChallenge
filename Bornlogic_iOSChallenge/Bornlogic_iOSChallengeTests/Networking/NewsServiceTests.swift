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

    func testExample() async throws {
        let data = try await serviceMock.fetchData(for: .topHeadlines, country: .brazil, category: .business)
    }
    
}
