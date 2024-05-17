//
//  NewsListViewModelTests.swift
//  Bornlogic_iOSChallengeTests
//
//  Created by Guilherme Viana on 17/05/2024.
//

import XCTest

@testable import Bornlogic_iOSChallenge

class NewsListViewModelDataTests: XCTestCase {
    var viewModel: NewsListViewModel!
    var fakeService: NewsServiceFake!
    var mockDelegate: NewsViewModelDelegateMock!

    override func setUp()  {
        super.setUp()
        fakeService = NewsServiceFake()
        viewModel = NewsListViewModel(newsService: fakeService)
        mockDelegate = NewsViewModelDelegateMock()
        viewModel.delegate = mockDelegate
    }

    override func tearDown()  {
        viewModel = nil
        fakeService = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchData_Success_UpdatesDataAndNotifiesDelegate() {
        let validData = [Article(source: Source(id: "id", name: "name"), 
                                 author: "author",
                                 title: "title",
                                 description: "description", 
                                 url: "url",
                                 urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2152436289.jpg?c=16x9&q=w_800,c_fill",
                                 publishedAt: Date.now,
                                 content: "content")]
                
        fakeService.fakeData = NewsData(articles: validData)

        viewModel.loadNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockDelegate.didCallNewsDataDidUpdate, "The delegate should be notified when the data is updated.")
            XCTAssertNotNil(self.viewModel.newsData, "The data in the view model should not be nil.")
            XCTAssertEqual(self.viewModel.newsData?.count, validData.count, "The data in the view model should be the same as the data returned by the service.")
        }
    }
    
    func testFetchData_FailureInvalidURL_NotifiesDelegate() {
        fakeService.errorToThrow = .invalidURL
        
        viewModel.loadNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockDelegate.didCallNewsDataDidFailWithError, "The delegate should be notified when there was an error.")
            XCTAssertNil(self.viewModel.newsData, "The data in the view model should be nil.")
        }
    }
    
    func testFetchData_FailureInvalidResponse_NotifiesDelegate() {
        fakeService.errorToThrow = .invalidResponse
        
        viewModel.loadNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockDelegate.didCallNewsDataDidFailWithError, "The delegate should be notified when there was an error.")
            XCTAssertNil(self.viewModel.newsData, "The data in the view model should be nil.")
        }
    }
    
    func testFetchData_FailureInvalidData_NotifiesDelegate() {
        fakeService.errorToThrow = .invalidData
        
        viewModel.loadNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockDelegate.didCallNewsDataDidFailWithError, "The delegate should be notified when there was an error.")
            XCTAssertNil(self.viewModel.newsData, "The data in the view model should be nil.")
        }
    }
    
    func testFilterData_RemovesRemovedArticles() {
        let articles = [
            Article(source: Source(id: "id", name: "name"),
                                author: "author",
                                title: "title",
                                description: "description",
                                url: "url",
                                urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2152436289.jpg?c=16x9&q=w_800,c_fill",
                                publishedAt: Date.now,
                                content: "content"),
            Article(source: Source(id: "id", name: "name"),
                                author: "[Removed]",
                                title: "[Removed]",
                                description: "[Removed]",
                                url: "[Removed]",
                                urlToImage: nil,
                                publishedAt: Date.now,
                                content: "[Removed]"),
            Article(source: Source(id: "id", name: "name"),
                                author: "author",
                                title: "title",
                                description: "description",
                                url: "url",
                                urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2152436289.jpg?c=16x9&q=w_800,c_fill",
                                publishedAt: Date.now,
                                content: "content"),
        ]
        
        let newsData = NewsData(articles: articles)
        let filteredArticles = viewModel.filterData(on: newsData, containingOnTitle: "[Removed]")
        
        XCTAssertEqual(filteredArticles?.count, 2, "Should filter out articles with '[Removed]' in the title")
        XCTAssertFalse(filteredArticles?.contains(where: { $0.title == "[Removed]" }) ?? true, "No article should have '[Removed]' in the title")
    }
}

class NewsListViewModelTableViewTests: XCTestCase {
    var viewModel: NewsListViewModel!
    var fakeService: NewsServiceFake!

    override func setUp()  {
        super.setUp()
        fakeService = NewsServiceFake()
        viewModel = NewsListViewModel(newsService: fakeService)
    }

    override func tearDown()  {
        viewModel = nil
        fakeService = nil
        super.tearDown()
    }
    
    func testTableView_GetNumberOfRows_ReturnsCorrectCount() {
        viewModel.newsData = [Article(source: Source(id: "id", name: "name"),
                                      author: "author",
                                      title: "title", 
                                      description: "description",
                                      url: "url",
                                      urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2152436289.jpg?c=16x9&q=w_800,c_fill",
                                      publishedAt: Date.now,
                                      content: "content")]

        XCTAssertEqual(viewModel.numberOfRowsInSection, viewModel.newsData?.count, "The number of rows should be the same as the number of articles in the data.")
    }
    
    func testTableView_GetCellForRowAt_ReturnsCorrectCell() {
        viewModel.newsData = [Article(source: Source(id: "id", name: "name"),
                                      author: "author",
                                      title: "title",
                                      description: "description",
                                      url: "url",
                                      urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2152436289.jpg?c=16x9&q=w_800,c_fill",
                                      publishedAt: Date.now,
                                      content: "content")]
        
        let tableView = UITableView()
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.identifier)
        
        let cell = viewModel.getCellForRow(on: tableView, at: IndexPath(row: 0, section: 0)) as? NewsListTableViewCell
        
        XCTAssertEqual(cell?.cellView.titleLabel.text, viewModel.newsData?.first?.title, "The cell should display the correct title of the article that is stored on the data variable.")
    }
}

extension NewsListViewModelDataTests {
    private func loadTestData() -> Data? {
        guard let url = Bundle(for: type(of: self)).url(forResource: "ValidNewsData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("Error loading test data file")
            return nil
        }
        return data
    }
}
