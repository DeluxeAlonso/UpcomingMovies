//
//  SearchOptionsDataSourceTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 9/09/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class SearchOptionsDataSourceTests: XCTestCase {

    private var viewModel: SearchOptionsViewModel!
    private var interactor = SearchOptionsInteractorMock()

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = SearchOptionsViewModel(interactor: interactor)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

}
