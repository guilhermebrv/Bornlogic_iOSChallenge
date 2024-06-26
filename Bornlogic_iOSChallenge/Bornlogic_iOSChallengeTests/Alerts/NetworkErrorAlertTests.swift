//
//  NetworkErrorAlertTests.swift
//  Bornlogic_iOSChallengeTests
//
//  Created by Guilherme Viana on 15/05/2024.
//

import XCTest

@testable import Bornlogic_iOSChallenge

class NetworkErrorAlertTests: XCTestCase {
    var viewController: NewsListViewController!
    var serviceFake: NewsServiceFake!
    var viewModel: NewsListViewModel!

    override func setUp() {
        super.setUp()
        viewController = NewsListViewController()
        serviceFake = NewsServiceFake()
        viewModel = NewsListViewModel(newsService: serviceFake)
        viewController.viewModel = viewModel
    }
    
    override func tearDown() {
        viewController = nil
        serviceFake = nil
        viewModel = nil
        super.tearDown()
    }

    func testNetworkAlert_whenInvalidURL_showAlert() {
        serviceFake.errorToThrow = .invalidURL
        
        viewModel.loadNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewController.alert, "Since the invalid URL alert is presented, its variable cannot be nil.")
            XCTAssertEqual(self.viewController.alert?.message, "The URL is invalid.")
        }
    }
    
    func testNetworkAlert_whenInvalidResponse_showAlert() {
        serviceFake.errorToThrow = .invalidResponse
        
        viewModel.loadNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewController.alert, "Since the invalid response alert is presented, its variable cannot be nil.")
            XCTAssertEqual(self.viewController.alert?.message, "The response from the server was invalid.")
        }
    }
    
    func testNetworkAlert_whenInvalidData_showAlert() {
        serviceFake.errorToThrow = .invalidData
        
        viewModel.loadNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewController.alert, "Since the invalid data alert is presented, its variable cannot be nil.")
            XCTAssertEqual(self.viewController.alert?.message, "The data received was corrupt or unreadable.")
        }
    }
}
