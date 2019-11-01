//
//  Crew.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

struct Crew: Decodable {
    
    let id: Int
    let job: String
    let name: String
    let profilePath: String?
 
    private enum CodingKeys: String, CodingKey {
        case id
        case job
        case name
        case profilePath = "profile_path"
    }
    
}

extension Crew {
    
    var profileURL: URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: URLConfiguration.mediaPath + profilePath)
    }
    
}
