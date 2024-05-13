//
//  CastProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol CastProtocol: ImageConfigurable {

    var id: Int { get }
    var character: String { get }
    var name: String { get }
    var profileURL: URL? { get }

}

extension Cast: CastProtocol {

    var profileURL: URL? {
        guard let photoPath = photoPath else { return nil }
        let urlString = regularImageBaseURLString.appending(photoPath)
        return URL(string: urlString)
    }

}
