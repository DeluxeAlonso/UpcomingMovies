//
//  MovieCreditCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 21/05/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

class MovieCreditCellViewModelTests: XCTestCase {

    func testNameForCreditModelCreatedWithCast() {
        // Arrange
        let nameToTest = "Alonso"
        let viewModel = createSUT(with: Cast.with(name: nameToTest))
        // Act
        let viewModelName = viewModel.name
        // Assert
        XCTAssertEqual(nameToTest, viewModelName)
    }

    func testRoleForCreditModelCreatedWithCast() {
        // Arrange
        let characterToTest = "Villain"
        let viewModel = createSUT(with: Cast.with(character: characterToTest))
        // Act
        let viewModelRole = viewModel.role
        // Assert
        XCTAssertEqual(characterToTest, viewModelRole)
    }

    func testProfileURLForCreditModelCreatedWithCast() {
        // Arrange
        let photoPathToTest = "/path"
        let viewModel = createSUT(with: Cast.with(photoPath: photoPathToTest))
        // Act
        let viewModelProfileURL = viewModel.profileURL
        // Assert
        XCTAssertEqual(URL(string: ImageConfigurationHandler.Constants.defaultRegularImageBaseURLString + photoPathToTest), viewModelProfileURL)
    }

    private func createSUT(with cast: Cast) -> MovieCreditCellViewModel {
        return MovieCreditCellViewModel(cast: cast)
    }

    private func createSUT(with crew: Crew) -> MovieCreditCellViewModel {
        return MovieCreditCellViewModel(crew: crew)
    }

}
