//
//  MovieDetailTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import UpcomingMoviesData
@testable import CoreDataInfrastructure

class MovieDetailTests: XCTestCase {
    
    private var viewModelToTest: MovieDetailViewModel!
    private var useCaseProvider: MockUseCaseProvider!
    private var movieUseCase: MockMovieUseCase!
    private var genreUseCase: MockGenreUseCase!

    override func setUp() {
        super.setUp()
        
        movieUseCase = MockMovieUseCase(remoteDataSource: MockInjectionFactory.makeRemoteDataSource().movieDataSource())
        genreUseCase = MockGenreUseCase(localDataSource: MockInjectionFactory.makeLocalDataSource().genreDataSource(),
                                        remoteDataSource: MockInjectionFactory.makeRemoteDataSource().genreDataSource())
        
        useCaseProvider = (MockInjectionFactory.useCaseProvider() as! MockUseCaseProvider)
        useCaseProvider.mockMovieUseCase = self.movieUseCase
        useCaseProvider.mockGenreUseCase = self.genreUseCase
        
        let movieToTest = Movie(id: 1,
                            title: "Test 1",
                            genreIds: [1, 2],
                            overview: "Overview",
                            posterPath: "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
                            backdropPath: "/2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg",
                            releaseDate: "2019-02-01", voteAverage: 4.5)
        viewModelToTest = MovieDetailViewModel(movieToTest, useCaseProvider: useCaseProvider)
    }

    override func tearDown() {
        viewModelToTest = nil
        useCaseProvider = nil
        genreUseCase = nil
        super.tearDown()
    }

    func testMovieDetailTitle() {
        //Act
        let title = viewModelToTest.title
        //Assert
        XCTAssertEqual(title, "Test 1")
    }
    
    func testMovieDetailReleaseDate() {
        //Act
        let releaseDate = viewModelToTest.releaseDate
        //Assert
        XCTAssertEqual(releaseDate, "2019-02-01")
    }
    
    func testMovieDetailOverview() {
        //Act
        let overview = viewModelToTest.overview
        //Assert
        XCTAssertEqual(overview, "Overview")
    }
    
    func testMovieDetailVoteAverage() {
        //Act
        let voteAverage = viewModelToTest.voteAverage
        //Assert
        XCTAssertEqual(voteAverage, 4.5)
    }
    
    func testMovieDetailPosterPath() {
        //Act
        let fullPosterPath = viewModelToTest.posterURL
        //Assert
        XCTAssertEqual(fullPosterPath!, URL(string: "https://image.tmdb.org/t/p/w185/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
    }
    
    func testMovieDetailBackdropPath() {
        //Act
        let fullBackdropPath = viewModelToTest.backdropURL
        //Assert
        XCTAssertEqual(fullBackdropPath!, URL(string: "https://image.tmdb.org/t/p/w500/2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg"))
    }
    
    //TO-DO: Implement a mocked use case provider
    func testMovieDetailGenre() {
        //Act
        let genre = viewModelToTest.genre
        //Assert
        XCTAssertEqual(genre!, "Genre 1")
    }
    
}
