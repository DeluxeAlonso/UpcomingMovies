//
//  Cast.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public struct Cast: Decodable {
    
    public let id: Int
    public let character: String
    public let name: String
    public let photoPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case character
        case name
        case photoPath = "profile_path"
    }
    
}

extension Cast: DomainConvertible {
    
    func asDomain() -> UpcomingMoviesDomain.Cast {
        return UpcomingMoviesDomain.Cast(id: id, character: character, name: name, photoPath: photoPath)
    }
    
}
