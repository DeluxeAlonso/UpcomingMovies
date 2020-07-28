//
//  CustomListsTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class CustomListsTests: XCTestCase {
    
    private var mockInteractor: MockCustomListsInteractor!
    private var viewModelToTest: CustomListsViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockCustomListsInteractor()
        viewModelToTest = CustomListsViewModel(interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockInteractor = nil
        viewModelToTest = nil
    }

}
