//
//  Entities+ImageConfiguration.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol ImageConfigurable {

    var configurationHandler: ConfigurationHandlerProtocol { get }

}

extension ImageConfigurable {

    var configurationHandler: ConfigurationHandlerProtocol {
        DIContainer.shared.resolve()
    }

    var regularImageBaseURLString: String {
        configurationHandler.regularImageBaseURLString
    }

    var backdropImageBaseURLString: String {
        configurationHandler.backdropImageBaseURLString
    }

    var avatarImageBaseURLString: String? {
        configurationHandler.avatarImageBaseURLString
    }

}

extension Movie: ImageConfigurable {

    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        let urlString = regularImageBaseURLString.appending(posterPath)
        return URL(string: urlString)
    }

    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        let urlString = backdropImageBaseURLString.appending(backdropPath)
        return URL(string: urlString)
    }

}

extension Cast: ImageConfigurable {

    var profileURL: URL? {
        guard let photoPath = photoPath else { return nil }
        let urlString = regularImageBaseURLString.appending(photoPath)
        return URL(string: urlString)
    }

}

extension Crew: ImageConfigurable {

    var profileURL: URL? {
        guard let photoPath = photoPath else { return nil }
        let urlString = regularImageBaseURLString.appending(photoPath)
        return URL(string: urlString)
    }

}

extension List: ImageConfigurable {

    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        let urlString = backdropImageBaseURLString.appending(backdropPath)
        return URL(string: urlString)
    }

}

extension User: ImageConfigurable {

    var avatarImageURL: URL? {
        guard let avatarPath, let avatarImageBaseURLString else { return nil }
        let urlString = avatarImageBaseURLString.appending(avatarPath)
        return URL(string: urlString)
    }

}
