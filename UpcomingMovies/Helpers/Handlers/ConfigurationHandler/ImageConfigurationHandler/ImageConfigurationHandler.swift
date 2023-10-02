//
//  ImageConfigurationHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

struct ImageConfigurationHandler: ImageConfigurationHandlerProtocol {

    private let configuration: Configuration

    init(configuration: Configuration) {
        self.configuration = configuration
    }

    private var baseURLString: String {
        configuration.imagesConfiguration.baseURLString
    }

    var regularImageBaseURLString: String {
        let posterSize = configuration.imagesConfiguration.posterSizes.mid ?? Constants.defaultRegularSize
        return baseURLString + posterSize
    }

    var backdropImageBaseURLString: String {
        let backdropSize = configuration.imagesConfiguration.backdropSizes.mid ?? Constants.defaultBackdropSize
        return baseURLString + backdropSize
    }

    var avatarImageBaseURLString: String {
        Constants.avatarImageBaseURLString
    }

}

// MARK: - Constants

extension ImageConfigurationHandler {

    struct Constants {

        static let defaultRegularSize: String = "w185"
        static let defaultBackdropSize: String = "w500"

        static let defaultRegularImageBaseURLString: String = "https://image.tmdb.org/t/p/w185"
        static let defaultBackdropImageBaseURLString: String = "https://image.tmdb.org/t/p/w500"

        static let avatarImageBaseURLString = "https://image.tmdb.org/t/p/w200/"
    }

}
