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

struct CrewModel: CrewProtocol {

    let id: Int
    let job: String
    let name: String
    private let photoPath: String?

    var profileURL: URL? {
        guard let photoPath = photoPath else { return nil }
        let urlString = regularImageBaseURLString.appending(photoPath)
        return URL(string: urlString)
    }

    init(_ crew: Crew) {
        self.id = crew.id
        self.job = crew.job
        self.name = crew.name
        self.photoPath = crew.photoPath
    }

}
