//
//  MovieReviewsTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import UpcomingMoviesData
@testable import NetworkInfrastructure

class MovieReviewsTests: XCTestCase {
    
    private var viewModelToTest: MovieReviewsViewModel!
    private var movieReviewCellViewModelToTest: MovieReviewCellViewModel!
    
    override func setUp() {
        super.setUp()
        let useCaseProvider = MockInjectionFactory.useCaseProvider()
        useCaseProvider.movieUseCase().
        viewModelToTest = MovieReviewsViewModel(movieId: 1, movieTitle: "Movie 1", useCaseProvider: <#UseCaseProviderProtocol#>)
        movieReviewCellViewModelToTest = MovieReviewCellViewModel(Review.with())
    }
    
    override func tearDown() {
        viewModelToTest = nil
        movieReviewCellViewModelToTest = nil
        super.tearDown()
    }
    
    func testMovieReviewsTitle() {
        //Act
        let title = viewModelToTest.movieTitle
        //Assert
        XCTAssertEqual(title, "Movie 1")
    }
    
    func testGetReviewsPopulated() {
        //Arrange
        let reviewResult = ReviewResult(results: [Review.with(id: "1"), Review.with(id: "2")],
                                        currentPage: 1, totalPages: 1)
        let mockupClient = MockMovieClient()
        mockupClient.getReviewResult = Result.success(reviewResult)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Review.with(id: "1"), Review.with(id: "2")]))
    }
    
    func testGetReviewsEmpty() {
        //Arrange
        let reviewResult = ReviewResult(results: [],
                                       currentPage: 1, totalPages: 1)
        let mockupClient = MockMovieClient()
        mockupClient.getReviewResult = Result.success(reviewResult)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetReviewsPaging() {
        //Arrange
        let reviewResult = ReviewResult(results: [Review.with(id: "1"), Review.with(id: "2")],
                                        currentPage: 1, totalPages: 2)
        let mockupClient = MockMovieClient()
        mockupClient.getReviewResult = Result.success(reviewResult)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value,
                       .paging([Review.with(id: "1"), Review.with(id: "2")], next: 2))
    }
    
    func testGetReviewsError() {
        //Arrange
        let mockupClient = MockMovieClient()
        mockupClient.getReviewResult = Result.failure(APIError.badRequest)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }

}

private final class MockMovieClient: MovieClient {
    
    var getReviewResult: Result<ReviewResult?, APIError>?
    
    override func getMovieReviews(page: Int, with movieId: Int, completion: @escaping (Result<ReviewResult?, APIError>) -> Void) {
        completion(getReviewResult!)
    }
    
}

private final class MockMovieUseCase: MovieRepository {
    
    var getReviewResult: Result<[Review], Error>?
    
    override func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[Review], Error>) -> Void) {
        completion(getReviewResult!)
    }
    
}

private final class MockUseCaseProvider: UseCaseProvider {
    
    var getReviewResult: Result<[Review], Error>?
    
    override func movieUseCase() -> MovieUseCaseProtocol {
        let movieUseCase = MockMovieUseCase(remoteDataSource: MovieRemoteDataSource(client: MovieClient()))
        movieUseCase.getReviewResult = getReviewResult
        return movieUseCase
    }
    
}
