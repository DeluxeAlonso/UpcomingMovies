//
//  UpcomingMoviesMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/7/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class MockUpcomingMoviesInteractor: MoviesInteractorProtocol {

    var displayTitle: String = "Upcoming Movies"

    var upcomingMovies: Result<[UpcomingMoviesDomain.Movie], Error>?
    func getMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let upcomingMovies {
            completion(upcomingMovies)
        }
    }

}

final class MockUpcomingMoviesFactory: UpcomingMoviesFactoryProtocol {

    var makeGridBarButtonItemContentsResult: [ToggleBarButtonItemContent] = []
    func makeGridBarButtonItemContents(for presentationMode: UpcomingMoviesPresentationMode) -> [ToggleBarButtonItemContent] {
        makeGridBarButtonItemContentsResult
    }

}

final class MockUpcomingMoviesNavigationDelegate: NSObject, UpcomingMoviesNavigationDelegate {

    var parentCoordinator: Coordinator?

    private(set) var configureCallCount = 0
    func configure(selectedFrame: CGRect?, with imageToTransition: UIImage?) {
        configureCallCount += 1
    }

    private(set) var updateOffsetCallCount = 0
    func updateOffset(_ verticalSafeAreaOffset: CGFloat) {
        updateOffsetCallCount += 1
    }

}
