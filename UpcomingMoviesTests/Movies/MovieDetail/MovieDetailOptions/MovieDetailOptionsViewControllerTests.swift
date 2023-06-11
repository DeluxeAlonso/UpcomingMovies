//
//  MovieDetailOptionsViewControllerTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class MovieDetailOptionsViewControllerTests: XCTestCase {

    private var viewModel: MockMovieDetailOptionsViewModel!
    private var delegate: MockMovieDetailOptionsViewControllerDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockMovieDetailOptionsViewModel()
        delegate = MockMovieDetailOptionsViewControllerDelegate()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        delegate = nil
        try super.tearDownWithError()
    }

    func testModelUpdate() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        let newViewModel = MockMovieDetailOptionsViewModel()
        newViewModel.options = [.credits, .reviews, .similarMovies, .trailers]
        // Act
        viewController.update(with: newViewModel)
        // Assert
        XCTAssertEqual(viewController.viewModel?.options, newViewModel.options)
    }

    func testModelUpdateAfterFirstUpdate() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        let firstViewModel = MockMovieDetailOptionsViewModel()
        firstViewModel.options = [.trailers]
        let newViewModel = MockMovieDetailOptionsViewModel()
        newViewModel.options = [.credits, .reviews, .similarMovies, .trailers]
        // Act
        viewController.update(with: firstViewModel)
        viewController.update(with: newViewModel)
        // Assert
        XCTAssertEqual(viewController.viewModel?.options, newViewModel.options)
    }

    func testOptionAction() {
        // Arrange
        let viewController = createSUT()
        let movieDetailOptionView = MovieDetailOptionView(option: .reviews)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
        movieDetailOptionView.addGestureRecognizer(tapGestureRecognizer)
        // Act
        viewController.perform(Selector("optionAction:"), with: tapGestureRecognizer)
        // Assert
        XCTAssertEqual(delegate.didSelectOptionCallCount, 1)
    }

    func testOptionActionInvalidTapGesture() {
        // Arrange
        let viewController = createSUT()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
        // Act
        viewController.perform(Selector("optionAction:"), with: tapGestureRecognizer)
        // Assert
        XCTAssertEqual(delegate.didSelectOptionCallCount, 0)
    }

    private func createSUT() -> MovieDetailOptionsViewController {
        let viewController = MovieDetailOptionsViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.delegate = delegate

        return viewController
    }

}
