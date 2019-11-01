//
//  MovieVideosTest.swift
//  UpcomingMoviesTests
//
//  Created by Alonso Alvarez on 2/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import Domain

class MovieVideosTest: XCTestCase {
    
    private var viewModelToTest: MovieVideosViewModel!
    private var movieVideoCellViewModelToTest: MovieVideoCellViewModel!

    override func setUp() {
        super.setUp()
        viewModelToTest = MovieVideosViewModel(movieId: 1, movieTitle: "Movie Test")
        movieVideoCellViewModelToTest = MovieVideoCellViewModel(Video.with())
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
    
    func testMovieVideoCellName() {
        //Act
        let name = movieVideoCellViewModelToTest.name
        //Assert
        XCTAssertEqual(name, "Video1")
    }
    
    func testMovieVideoCellKey() {
        //Act
        let key = movieVideoCellViewModelToTest.key
        //Assert
        XCTAssertEqual(key, "ABC")
    }
    
    func testMovieVideoCellThumbnailURL() {
        //Act
        let thumbnailURL = movieVideoCellViewModelToTest.thumbnailURL
        //Assert
        XCTAssertEqual(thumbnailURL, URL(string: "https://img.youtube.com/vi/ABC/mqdefault.jpg"))
    }

}

private final class MockMovieClient: MovieClient {
    
    var getVideoResult: Result<VideoResult?, APIError>?
    
    override func getMovieVideos(with movieId: Int, completion: @escaping (Result<VideoResult?, APIError>) -> Void) {
        completion(getVideoResult!)
    }
    
}
