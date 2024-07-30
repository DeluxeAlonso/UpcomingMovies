//
//  ProfileAccountInfoCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 5/10/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class ProfileAccountInfoCellViewModelTests: XCTestCase {

    func testName() {
        // Arrange
        let nameToTest = "Name"
        let viewModel = createSUT(with: MockUserProtocol(name: nameToTest))
        // Act
        let viewModelName = viewModel.name
        // Assert
        XCTAssertEqual(nameToTest, viewModelName)
    }

    func testUsername() {
        // Arrange
        let usernameToTest = "Username"
        let viewModel = createSUT(with: MockUserProtocol(username: usernameToTest))
        // Act
        let viewModelUsername = viewModel.username
        // Assert
        XCTAssertEqual(usernameToTest, viewModelUsername)
    }

    private func createSUT(with user: UserProtocol) -> ProfileAccountInfoCellViewModel {
        ProfileAccountInfoCellViewModel(userAccount: user)
    }

}
