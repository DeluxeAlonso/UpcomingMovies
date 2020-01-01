//
//  Crew.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public struct Crew: Decodable {
    
    public let id: Int
    public let job: String
    public let name: String
    public let profilePath: String?
 
    private enum CodingKeys: String, CodingKey {
        case id
        case job
        case name
        case profilePath = "profile_path"
    }
    
}

extension Crew {
    
    public var profileURL: URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: URLConfiguration.mediaPath + profilePath)
    }
    
}

extension Crew: DomainConvertible {
    
    func asDomain() -> UpcomingMoviesDomain.Crew {
        return UpcomingMoviesDomain.Crew(id: id, job: job, name: name, profileURL: profileURL)
    }
    
}
