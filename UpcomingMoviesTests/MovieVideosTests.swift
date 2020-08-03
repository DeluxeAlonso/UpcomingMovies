//
//  MovieVideosTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso Alvarez on 2/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class MovieVideosTests: XCTestCase {
    
    private var mockInteractor: MockMovieVideosInteractor!
    private var viewModelToTest: MovieVideosViewModelProtocol!

    override func setUp() {
        super.setUp()
        mockInteractor = MockMovieVideosInteractor()
        viewModelToTest = MovieVideosViewModel(movieId: 1,
                                               movieTitle: "Movie Test",
                                               interactor: mockInteractor)
        
    }
    
    override func tearDown() {
        mockInteractor = nil
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
        mockInteractor.getMovieVideosResult = Result.success([Video.with(id: "1"), Video.with(id: "2")])
        //Act
        viewModelToTest.getMovieVideos(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Video.with(id: "1"), Video.with(id: "2")]))
    }
    
    func testGetVideosEmpty() {
        //Arrange
        mockInteractor.getMovieVideosResult = Result.success([])
        //Act
        viewModelToTest.getMovieVideos(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetVideosError() {
        //Arrange
        mockInteractor.getMovieVideosResult = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getMovieVideos(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }
    
    func testMovieVideoCellName() {
        //Arrange
        let cellViewModel = MovieVideoCellViewModel(Video.with())
        //Act
        let name = cellViewModel.name
        //Assert
        XCTAssertEqual(name, "Video1")
    }
    
    func testMovieVideoCellKey() {
        //Arrange
        let cellViewModel = MovieVideoCellViewModel(Video.with())
        //Act
        let key = cellViewModel.key
        //Assert
        XCTAssertEqual(key, "ABC")
    }
    
    func testMovieVideoCellThumbnailURL() {
        //Arrange
        let cellViewModel = MovieVideoCellViewModel(Video.with())
        //Act
        let thumbnailURL = cellViewModel.thumbnailURL
        //Assert
        XCTAssertEqual(thumbnailURL, URL(string: "https://img.youtube.com/vi/ABC/mqdefault.jpg"))
    }

}
