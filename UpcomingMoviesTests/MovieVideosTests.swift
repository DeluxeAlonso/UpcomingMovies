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
    
    private var movieUseCase: MockMovieUseCase!
    private var viewModelToTest: MovieVideosViewModelProtocol!

    override func setUp() {
        super.setUp()
        movieUseCase = MockMovieUseCase(remoteDataSource: MockInjectionFactory.makeRemoteDataSource().movieDataSource())
        
        let useCaseProvider = (MockInjectionFactory.useCaseProvider() as! MockUseCaseProvider)
        useCaseProvider.mockMovieUseCase = self.movieUseCase
        
        viewModelToTest = MovieVideosViewModel(movieId: 1,
                                               movieTitle: "Movie Test",
                                               useCaseProvider: useCaseProvider)
        
    }
    
    override func tearDown() {
        movieUseCase = nil
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
        movieUseCase.videos = Result.success([Video.with(id: "1"), Video.with(id: "2")])
        //Act
        viewModelToTest.getMovieVideos(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Video.with(id: "1"), Video.with(id: "2")]))
    }
    
    func testGetVideosEmpty() {
        //Arrange
        movieUseCase.videos = Result.success([])
        //Act
        viewModelToTest.getMovieVideos(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetVideosError() {
        //Arrange
        movieUseCase.videos = Result.failure(APIError.badRequest)
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
