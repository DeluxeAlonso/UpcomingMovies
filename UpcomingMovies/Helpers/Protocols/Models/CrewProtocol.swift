//
//  CrewProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol CrewProtocol: ImageConfigurable {

    var id: Int { get }
    var job: String { get }
    var name: String { get }
    var profileURL: URL? { get }

}

extension Crew: CrewProtocol {

    var profileURL: URL? {
        guard let photoPath = photoPath else { return nil }
        let urlString = regularImageBaseURLString.appending(photoPath)
        return URL(string: urlString)
    }

}
