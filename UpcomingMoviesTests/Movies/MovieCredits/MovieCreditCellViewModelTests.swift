//
//  MovieCreditCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 21/05/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class MovieCreditCellViewModelTests: XCTestCase {

    func testNameForCreditModelCreatedWithCast() {
        // Arrange
        let cast = MockCastProtocol(name: "Alonso")
        let viewModel = createSUT(with: cast)
        // Act
        let viewModelName = viewModel.name
        // Assert
        XCTAssertEqual("Alonso", viewModelName)
    }

    func testRoleForCreditModelCreatedWithCast() {
        // Arrange
        let cast = MockCastProtocol(character: "Villain")
        let viewModel = createSUT(with: cast)
        // Act
        let viewModelRole = viewModel.role
        // Assert
        XCTAssertEqual("Villain", viewModelRole)
    }

    func testProfileURLForCreditModelCreatedWithCast() {
        // Arrange
        let cast = MockCastProtocol(profileURL: URL(string: "https://image.tmdb.org/t/p/w185/path"))
        let viewModel = createSUT(with: cast)
        // Act
        let viewModelProfileURL = viewModel.profileURL
        // Assert
        XCTAssertEqual(URL(string: "https://image.tmdb.org/t/p/w185/path"), viewModelProfileURL)
    }

    func testNameForCreditModelCreatedWithCrew() {
        // Arrange
        let crew = MockCrewProtocol(name: "Villain")
        let viewModel = createSUT(with: crew)
        // Act
        let viewModelName = viewModel.name
        // Assert
        XCTAssertEqual("Villain", viewModelName)
    }

    func testRoleForCreditModelCreatedWithCrew() {
        // Arrange
        let crew = MockCrewProtocol(job: "Assistant")
        let viewModel = createSUT(with: crew)
        // Act
        let viewModelRole = viewModel.role
        // Assert
        XCTAssertEqual("Assistant", viewModelRole)
    }

    func testProfileURLForCreditModelCreatedWithCrew() {
        // Arrange
        let crew = MockCrewProtocol(profileURL: URL(string: "https://image.tmdb.org/t/p/w185/path"))
        let viewModel = createSUT(with: crew)
        // Act
        let viewModelProfileURL = viewModel.profileURL
        // Assert
        XCTAssertEqual(URL(string: "https://image.tmdb.org/t/p/w185/path"), viewModelProfileURL)
    }

    private func createSUT(with cast: CastProtocol) -> MovieCreditCellViewModel {
        MovieCreditCellViewModel(cast: cast)
    }

    private func createSUT(with crew: CrewProtocol) -> MovieCreditCellViewModel {
        MovieCreditCellViewModel(crew: crew)
    }

}
