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
    
    private var useCaseProvider: MockUseCaseProvider!
    private var movieUseCase: MockMovieUseCase!
    
    private var movieVideoCellViewModel: MovieVideoCellViewModel!

    override func setUp() {
        super.setUp()
        movieUseCase = MockMovieUseCase(remoteDataSource: MockInjectionFactory.makeRemoteDataSource().movieDataSource())
        useCaseProvider = (MockInjectionFactory.useCaseProvider() as! MockUseCaseProvider)
        useCaseProvider.mockMovieUseCase = self.movieUseCase
        
        movieVideoCellViewModel = MovieVideoCellViewModel(Video.with())
    }
    
    override func tearDown() {
        useCaseProvider = nil
        movieUseCase = nil
        movieVideoCellViewModel = nil
        super.tearDown()
    }
    
    func testMovieVideosTitle() {
        //Arrange
        let viewModel = MovieVideosViewModel(movieId: 1,
                                             movieTitle: "Movie Test",
                                             useCaseProvider: useCaseProvider)
        //Act
        let title = viewModel.movieTitle
        //Assert
        XCTAssertEqual(title, "Movie Test")
    }
    
    func testGetVideosPopulated() {
        //Arrange
        movieUseCase.videos = Result.success([Video.with(id: "1"), Video.with(id: "2")])
        let viewModel = MovieVideosViewModel(movieId: 1, movieTitle: "Movie 1", useCaseProvider: useCaseProvider)
        //Act
        viewModel.getMovieVideos()
        //Assert
        XCTAssertEqual(viewModel.viewState.value, .populated([Video.with(id: "1"), Video.with(id: "2")]))
    }
    
    func testGetVideosEmpty() {
        //Arrange
        movieUseCase.videos = Result.success([])
        let viewModel = MovieVideosViewModel(movieId: 1, movieTitle: "Movie 1", useCaseProvider: useCaseProvider)
        //Act
        viewModel.getMovieVideos()
        //Assert
        XCTAssertEqual(viewModel.viewState.value, .empty)
    }
    
    func testGetVideosError() {
        //Arrange
        movieUseCase.videos = Result.failure(APIError.badRequest)
        let viewModel = MovieVideosViewModel(movieId: 1, movieTitle: "Movie 1", useCaseProvider: useCaseProvider)
        //Act
        viewModel.getMovieVideos()
        //Assert
        XCTAssertEqual(viewModel.viewState.value, .error(APIError.badRequest))
    }
    
    func testMovieVideoCellName() {
        //Act
        let name = movieVideoCellViewModel.name
        //Assert
        XCTAssertEqual(name, "Video1")
    }
    
    func testMovieVideoCellKey() {
        //Act
        let key = movieVideoCellViewModel.key
        //Assert
        XCTAssertEqual(key, "ABC")
    }
    
    func testMovieVideoCellThumbnailURL() {
        //Act
        let thumbnailURL = movieVideoCellViewModel.thumbnailURL
        //Assert
        XCTAssertEqual(thumbnailURL, URL(string: "https://img.youtube.com/vi/ABC/mqdefault.jpg"))
    }

}
