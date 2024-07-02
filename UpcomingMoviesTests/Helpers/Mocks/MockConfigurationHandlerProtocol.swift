//
//  MockConfigurationHandlerProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 30/06/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MockConfigurationHandlerProtocol: ConfigurationHandlerProtocol {

    var regularImageBaseURLString: String
    var backdropImageBaseURLString: String
    var avatarImageBaseURLString: String?

    init(regularImageBaseURLString: String = "https://image.tmdb.org/t/p/regular",
         backdropImageBaseURLString: String = "https://image.tmdb.org/t/p/backdrop",
         avatarImageBaseURLString: String? = "https://image.tmdb.org/t/p/avatar") {
        self.regularImageBaseURLString = regularImageBaseURLString
        self.backdropImageBaseURLString = backdropImageBaseURLString
        self.avatarImageBaseURLString = avatarImageBaseURLString
    }

    func setConfiguration(_ configuration: Configuration) {}

}
