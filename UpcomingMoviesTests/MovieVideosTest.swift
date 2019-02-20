//
//  MovieVideosTest.swift
//  UpcomingMoviesTests
//
//  Created by Alonso Alvarez on 2/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class MovieVideosTest: XCTestCase {
    
    private var viewModelToTest: MovieVideosViewModel!

    override func setUp() {
        super.setUp()
        viewModelToTest = MovieVideosViewModel(movieId: 1, movieTitle: "Movie Test")
    }

    override func tearDown() {
        viewModelToTest = nil
        super.tearDown()
    }

    func testMovieVideosTitle() {
        //Act
        let title = viewModelToTest.movieTitle
        //Assert
        XCTAssertEqual(title, "Movie Test")
    }
    
    func testGetVideosPopulated() {
        //Arrange
        let videoResult = VideoResult(results: [Video.with(id: "1"), Video.with(id: "2")])
        let mockupClient = MockMovieClient()
        mockupClient.getVideoResult = Result.success(videoResult)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovieVideos()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Video.with(id: "1"), Video.with(id: "2")]))
    }
    
    func testGetVideosEmpty() {
        //Arrange
        let videoResult = VideoResult(results: [])
        let mockupClient = MockMovieClient()
        mockupClient.getVideoResult = Result.success(videoResult)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovieVideos()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetVideosError() {
        //Arrange
        let mockupClient = MockMovieClient()
        mockupClient.getVideoResult = Result.failure(APIError.badRequest)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovieVideos()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }

}

private final class MockMovieClient: MovieClient {
    
    var getVideoResult: Result<VideoResult?, APIError>?
    
    override func getMovieVideos(with movieId: Int, completion: @escaping (Result<VideoResult?, APIError>) -> Void) {
        completion(getVideoResult!)
    }
    
}
