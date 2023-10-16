//
//  MovieClientTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 21/08/23.
//

import XCTest
@testable import NetworkInfrastructure

// swiftlint:disable all
final class MovieClientTests: XCTestCase {

    private var urlSession: MockURLSession!
    private var movieClient: MovieClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
        urlSession = MockURLSession()
        movieClient = MovieClient(session: urlSession)

    }

    override func tearDownWithError() throws {
        urlSession = nil
        movieClient = nil
        try super.tearDownWithError()
    }

    func testGetPopularMoviesSuccess() throws {
        // Arrange
        let data = MockResponse.movieResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get popular movies success")
        // Act
        movieClient.getPopularMovies(page: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get popular movies error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetPopularMoviesError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get popular movies error")
        // Act
        movieClient.getPopularMovies(page: 1) { result in
            switch result {
            case .success:
                XCTFail("Get popular movies success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetUpcomingMoviesError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get upcoming movies error")
        // Act
        movieClient.getUpcomingMovies(page: 1) { result in
            switch result {
            case .success:
                XCTFail("Get Upcoming movies success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetUpcomingMoviesSuccess() throws {
        // Arrange
        let data = MockResponse.movieResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get upcoming movies success")
        // Act
        movieClient.getUpcomingMovies(page: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get upcoming movies error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetTopRatedMoviesError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get top rated movies error")
        // Act
        movieClient.getTopRatedMovies(page: 1) { result in
            switch result {
            case .success:
                XCTFail("Get top rated movies success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetTopRatedMoviesSuccess() throws {
        // Arrange
        let data = MockResponse.movieResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get top rated movies success")
        // Act
        movieClient.getTopRatedMovies(page: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get top rated movies error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetSimilarMoviesError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get top rated movies error")
        // Act
        movieClient.getSimilarMovies(page: 1, movieId: 1) { result in
            switch result {
            case .success:
                XCTFail("Get top rated movies success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetSimilarMoviesSuccess() throws {
        // Arrange
        let data = MockResponse.movieResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get similar movies success")
        // Act
        movieClient.getSimilarMovies(page: 1, movieId: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get similar movies error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMoviesByGenreError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get movies by genre error")
        // Act
        movieClient.getMoviesByGenre(page: 1, genreId: 1) { result in
            switch result {
            case .success:
                XCTFail("Get movies by genre success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMoviesByGenreSuccess() throws {
        // Arrange
        let data = MockResponse.movieResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get movies by genre success")
        // Act
        movieClient.getMoviesByGenre(page: 1, genreId: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get movies by genre error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchMoviesError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Search movies error")
        // Act
        movieClient.searchMovies(searchText: "", includeAdult: false) { result in
            switch result {
            case .success:
                XCTFail("Search movies success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchMoviesSuccess() throws {
        // Arrange
        let data = MockResponse.movieResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Search movies success")
        // Act
        movieClient.searchMovies(searchText: "", includeAdult: false) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Search movies error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieDetailError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get movie detail error")
        // Act
        movieClient.getMovieDetail(with: 1) { result in
            switch result {
            case .success:
                XCTFail("Get movie detail success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieDetailSuccess() throws {
        // Arrange
        let data = MockResponse.movieDetailResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get movie detail success")
        // Act
        movieClient.getMovieDetail(with: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get movie detail error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieVideosError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get movie videos error")
        // Act
        movieClient.getMovieVideos(with: 1) { result in
            switch result {
            case .success:
                XCTFail("Get movie videos success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieVideosSuccess() throws {
        // Arrange
        let data = MockResponse.videoResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get movie videos success")
        // Act
        movieClient.getMovieVideos(with: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get movie videos error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieReviewsError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get movie reviews error")
        // Act
        movieClient.getMovieReviews(page: 1, with: 1) { result in
            switch result {
            case .success:
                XCTFail("Get movie reviews success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieReviewsSuccess() throws {
        // Arrange
        let data = MockResponse.reviewResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get movie reviews success")
        // Act
        movieClient.getMovieReviews(page: 1, with: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get movie reviews error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieCreditsError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get movie credits error")
        // Act
        movieClient.getMovieCredits(with: 1) { result in
            switch result {
            case .success:
                XCTFail("Get movie credits success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieCreditsSuccess() throws {
        // Arrange
        let data = MockResponse.creditResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get movie credits success")
        // Act
        movieClient.getMovieCredits(with: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get movie credits error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieAccountStateError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get movie account state error")
        // Act
        movieClient.getMovieAccountState(with: 1, sessionId: "") { result in
            switch result {
            case .success:
                XCTFail("Get movie account state success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieAccountStateSuccess() throws {
        // Arrange
        let data = MockResponse.accountStateResult.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get movie account state success")
        // Act
        movieClient.getMovieAccountState(with: 1, sessionId: "") { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get movie account state error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testRateMovieError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Rate movie error")
        // Act
        movieClient.rateMovie(movieId: 1, sessionId: "", value: 4) { result in
            switch result {
            case .success:
                XCTFail("Rate movie success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testRateMovieSuccess() throws {
        // Arrange
        let data = MockResponse.rateMovie.dataResponse
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Rate movie success")
        // Act
        movieClient.rateMovie(movieId: 1, sessionId: "", value: 4) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Rate movie error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

}
