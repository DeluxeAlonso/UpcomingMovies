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
