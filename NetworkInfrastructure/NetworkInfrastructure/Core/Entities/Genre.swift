//
//  Genre.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

struct Genre: Codable {

    let id: Int
    let name: String

}

extension Genre: DomainConvertible {

    func asDomain() -> UpcomingMoviesDomain.Genre {
        UpcomingMoviesDomain.Genre(id: id, name: name)
    }

}
