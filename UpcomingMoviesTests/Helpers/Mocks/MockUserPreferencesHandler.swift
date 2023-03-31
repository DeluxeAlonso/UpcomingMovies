//
//  MockUserPreferencesHandler.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 12/02/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

@testable import UpcomingMovies

final class MockUserPreferencesHandler: UserPreferencesHandlerProtocol {

    var upcomingMoviesPresentationMode: UpcomingMoviesPresentationMode = .preview

}
