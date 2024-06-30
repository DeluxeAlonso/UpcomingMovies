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

struct CastModel: CastProtocol {

    let id: Int
    let character: String
    let name: String
    let photoPath: String?

    let configurationHandler: ConfigurationHandlerProtocol

    init(_ cast: Cast, configurationHandler: ConfigurationHandlerProtocol) {
        self.id = cast.id
        self.character = cast.character
        self.name = cast.name
        self.photoPath = cast.photoPath
        self.configurationHandler = configurationHandler
    }

    init(_ cast: Cast) {
        self.init(cast, configurationHandler: DIContainer.shared.resolve())
    }

    var profileURL: URL? {
        guard let photoPath = photoPath else { return nil }
        let urlString = regularImageBaseURLString.appending(photoPath)
        return URL(string: urlString)
    }

}
