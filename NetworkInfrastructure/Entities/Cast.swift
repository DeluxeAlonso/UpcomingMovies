//
//  Cast.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public struct Cast: Decodable {
    
    public let id: Int
    public let character: String
    public let name: String
    public let profilePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case character
        case name
        case profilePath = "profile_path"
    }
    
}

extension Cast {
    
    public var profileURL: URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: URLConfiguration.mediaPath + profilePath)
    }
    
}

extension Cast: DomainConvertible {
    
    func asDomain() -> UpcomingMoviesDomain.Cast {
        return UpcomingMoviesDomain.Cast(id: id, character: character, name: name, profileURL: profileURL)
    }
    
}
