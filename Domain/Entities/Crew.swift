//
//  Crew.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

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
