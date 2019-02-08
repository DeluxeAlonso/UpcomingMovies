//
//  UpcomingMoviesTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class UpcomingMoviesTests: XCTestCase {
    
    var viewModelToTest: UpcomingMoviesViewModel!
    var moviesToTest: [Movie]!

    override func setUp() {
        super.setUp()
        viewModelToTest = UpcomingMoviesViewModel()
        moviesToTest = [
            Movie(id: 1,
                  title: "Test 1",
                  genres: nil,
                  overview: "",
                  posterPath: "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
                  backdropPath: nil, releaseDate: "2019-02-01", voteAverage: nil),
            Movie(id: 2,
                  title: "Test 2",
                  genres: nil,
                  overview: "",
                  posterPath: "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
                  backdropPath: nil, releaseDate: "2020-02-01", voteAverage: nil)
        ]
    }

    override func tearDown() {
        viewModelToTest = nil
        moviesToTest = nil
        super.tearDown()
    }
    
    // MARK: - View Model Test
    
    func testMovieCellsCount() {
        // Arrange
        viewModelToTest.viewState.value = .populated(moviesToTest)
        // Act
        let movieCellCount = viewModelToTest.movieCells.count
        // Assert
        XCTAssertEqual(movieCellCount, 2)
    }
    
    func testSelectedMovieCell() {
        // Arrange
        viewModelToTest.viewState.value = .populated(moviesToTest)
        // Act
        viewModelToTest.setSelectedMovie(at: 0)
        let selectedMovieCell = viewModelToTest.selectedMovieCell
        let movieFullPosterPath = selectedMovieCell?.fullPosterPath
        // Assert
        XCTAssertEqual(movieFullPosterPath, URL(string: "https://image.tmdb.org/t/p/w185/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
    }

}
