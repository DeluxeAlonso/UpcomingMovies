//
//  MovieDetailTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class MovieDetailTests: XCTestCase {
    
    var viewModelToTest: MovieDetailViewModel!
    var movieToTest: Movie!

    override func setUp() {
        super.setUp()
        let genres = [Genre(id: 1, name: "Genre 1"), Genre(id: 2, name: "Genre 2")]
        AppManager.shared.genres = genres
        movieToTest = Movie(id: 1,
                            title: "Test 1",
                            genres: [1, 2],
                            overview: "Overview",
                            posterPath: "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
                            backdropPath: "/2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg",
                            releaseDate: "2019-02-01", voteAverage: 4.5)
        viewModelToTest = MovieDetailViewModel(movieToTest)
    }

    override func tearDown() {
        movieToTest = nil
        viewModelToTest = nil
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
        let fullPosterPath = viewModelToTest.fullPosterPath
        //Assert
        XCTAssertEqual(fullPosterPath!, URL(string: "https://image.tmdb.org/t/p/w500/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
    }
    
    func testMovieDetailBackdropPath() {
        //Act
        let fullBackdropPath = viewModelToTest.fullBackdropPath
        //Assert
        XCTAssertEqual(fullBackdropPath!, URL(string: "https://image.tmdb.org/t/p/w500/2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg"))
    }
    
    func testMovieDetailGenre() {
        //Act
        let genre = viewModelToTest.genre
        //Assert
        XCTAssertEqual(genre!, "Genre 1")
    }

}
