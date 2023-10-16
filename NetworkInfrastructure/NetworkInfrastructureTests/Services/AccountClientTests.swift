//
//  AccountClientTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 3/09/23.
//

import XCTest
@testable import NetworkInfrastructure

final class AccountClientTests: XCTestCase {

    private var urlSession: MockURLSession!
    private var accountClient: AccountClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
        urlSession = MockURLSession()
        accountClient = AccountClient(session: urlSession)
    }

    override func tearDownWithError() throws {
        urlSession = nil
        accountClient = nil
        try super.tearDownWithError()
    }

    func testGetFavoriteListSuccess() throws {
        // Arrange
        let data = MockResponse.movieResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get favorite list success")
        // Act
        accountClient.getFavoriteList(page: 1, sortBy: .createdAtAsc, sessionId: "", accountId: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get favorite list error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetFavoriteListError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get favorite list error")
        // Act
        accountClient.getFavoriteList(page: 1, sortBy: .createdAtAsc, sessionId: "", accountId: 1) { result in
            switch result {
            case .success:
                XCTFail("Get favorite list success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetWatchlistSuccess() throws {
        // Arrange
        let data = MockResponse.movieResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get watchlist success")
        // Act
        accountClient.getWatchlist(page: 1, sortBy: .createdAtAsc, sessionId: "", accountId: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get watchlist error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetWatchlistError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get watchlist error")
        // Act
        accountClient.getWatchlist(page: 1, sortBy: .createdAtAsc, sessionId: "", accountId: 1) { result in
            switch result {
            case .success:
                XCTFail("Get watchlist success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetRecommendedListSuccess() throws {
        // Arrange
        let data = MockResponse.movieResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get recommended list success")
        // Act
        accountClient.getRecommendedList(page: 1, accessToken: "", accountId: "") { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get recommended list error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetRecommendedListError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get recommended list error")
        // Act
        accountClient.getRecommendedList(page: 1, accessToken: "", accountId: "") { result in
            switch result {
            case .success:
                XCTFail("Get recommended list success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListsSuccess() throws {
        // Arrange
        let data = MockResponse.listResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get custom lists success")
        // Act
        accountClient.getCustomLists(page: 1, accessToken: "", accountId: "") { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get custom lists error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListsError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get custom lists error")
        // Act
        accountClient.getCustomLists(page: 1, accessToken: "", accountId: "") { result in
            switch result {
            case .success:
                XCTFail("Get custom lists success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListMoviesSuccess() throws {
        // Arrange
        let data = MockResponse.movieResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get custom list movies success")
        // Act
        accountClient.getCustomListMovies(with: "", listId: "") { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get custom list movies error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListMoviesError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get custom list movies error")
        // Act
        accountClient.getCustomListMovies(with: "", listId: "") { result in
            switch result {
            case .success:
                XCTFail("Get custom list movies success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetAccountDetailSuccess() throws {
        // Arrange
        let data = MockResponse.user.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get account detail success")
        // Act
        accountClient.getAccountDetail(with: "") { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get account detail error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetAccountDetailError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get account detail error")
        // Act
        accountClient.getAccountDetail(with: "") { result in
            switch result {
            case .success:
                XCTFail("Get account detail success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testMarkAsFavoriteSuccess() throws {
        // Arrange
        let data = MockResponse.markAsFavorite.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Mark as favorite success")
        // Act
        accountClient.markAsFavorite(1, sessionId: "", accountId: 1, favorite: true) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Mark as favorite error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testMarkAsFavoriteError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Mark as favorite error")
        // Act
        accountClient.markAsFavorite(1, sessionId: "", accountId: 1, favorite: true) { result in
            switch result {
            case .success:
                XCTFail("Mark as favorite success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testAddToWatchlistSuccess() throws {
        // Arrange
        let data = MockResponse.addToWatchlist.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Add to watchlist success")
        // Act
        accountClient.addToWatchlist(1, sessionId: "", accountId: 1, watchlist: true) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Add to watchlist error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testAddToWatchlistError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Add to watchlist error")
        // Act
        accountClient.addToWatchlist(1, sessionId: "", accountId: 1, watchlist: true) { result in
            switch result {
            case .success:
                XCTFail("Add to watchlist success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

}
