//
//  ConfigurationHandlerProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 15/03/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol ConfigurationHandlerProtocol {

    var regularImageBaseURLString: String { get }
    var backdropImageBaseURLString: String { get }
    var avatarImageBaseURLString: String? { get }

    func setConfiguration(_ configuration: Configuration)

}
