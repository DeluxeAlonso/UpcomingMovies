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

    private var dataSource: SearchOptionsDataSource!
    private var viewModel: MockSearchOptionsViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockSearchOptionsViewModel()
        dataSource = SearchOptionsDataSource(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        dataSource = nil
        viewModel = nil
        try super.tearDownWithError()
    }

}
