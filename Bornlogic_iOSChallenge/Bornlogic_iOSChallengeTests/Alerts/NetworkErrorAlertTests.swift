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
    var serviceMock: NewsServiceMock!
    var viewModel: NewsListViewModel!

    override func setUp() {
        super.setUp()
        viewController = NewsListViewController()
        serviceMock = NewsServiceMock()
        viewModel = NewsListViewModel(newsService: serviceMock)
        viewController.viewModel = viewModel
    }
    
    override func tearDown() {
        viewController = nil
        serviceMock = nil
        viewModel = nil
        super.tearDown()
    }

    func testNetworkAlert_whenInvalidURL_showAlert() async {
        serviceMock.errorToThrow = .invalidURL
        
        await viewController.viewModel.loadNews()

        //The Swift await keyword ensures that the loadNews() function's asynchronous logic has completed, but it does not guarantee that any UI updates triggered by this logic (like displaying an alert) are rendered immediately. UI updates in iOS are scheduled to run on the next cycle of the main run loop. This means even though your async code has completed, the UI might not reflect this immediately.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewController.alert, "Since the invalid URL alert is presented, its variable cannot be nil.")
            XCTAssertEqual(self.viewController.alert?.message, "The URL is invalid.")
        }
    }
    
    func testNetworkAlert_whenInvalidResponse_showAlert() async {
        serviceMock.errorToThrow = .invalidResponse
        
        await viewController.viewModel.loadNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewController.alert, "Since the invalid response alert is presented, its variable cannot be nil.")
            XCTAssertEqual(self.viewController.alert?.message, "The response from the server was invalid.")
        }
    }
    
    func testNetworkAlert_whenInvalidData_showAlert() async {
        serviceMock.errorToThrow = .invalidData
        
        await viewController.viewModel.loadNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewController.alert, "Since the invalid data alert is presented, its variable cannot be nil.")
            XCTAssertEqual(self.viewController.alert?.message, "The data received was corrupt or unreadable.")
        }
    }
}
