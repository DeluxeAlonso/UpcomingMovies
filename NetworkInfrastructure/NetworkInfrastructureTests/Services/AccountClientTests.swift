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
        let data = try JSONEncoder().encode(MovieResult(results: [], currentPage: 1, totalPages: 1))
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
        let data = try JSONEncoder().encode(MovieResult(results: [], currentPage: 1, totalPages: 1))
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
        let data = try JSONEncoder().encode(MovieResult(results: [], currentPage: 1, totalPages: 1))
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
        let data = try JSONEncoder().encode(ListResult(results: [], currentPage: 1, totalPages: 1 ))
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

    func testCustomListMoviesSuccess() throws {
        // Arrange
        let data = try JSONEncoder().encode(ListResult(results: [], currentPage: 1, totalPages: 1 ))
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get custom lists success")
        // Act
        accountClient.getCustomListMovies(with: "", listId: "") { result in
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

    func testCustomListMoviesError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get custom lists error")
        // Act
        accountClient.getCustomListMovies(with: "", listId: "") { result in
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

}
