//
//  Cast.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

struct Cast: Decodable {

    let id: Int
    let character: String
    let name: String
    let photoPath: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case character
        case name
        case photoPath = "profile_path"
    }

}

extension Cast: DomainConvertible {

    func asDomain() -> UpcomingMoviesDomain.Cast {
        UpcomingMoviesDomain.Cast(id: id, character: character, name: name, photoPath: photoPath)
    }

}
