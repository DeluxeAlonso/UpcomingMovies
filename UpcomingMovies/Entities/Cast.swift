//
//  Cast.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

struct Cast: Decodable {
    
    let id: Int
    let character: String
    let name: String
    let profilePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case character
        case name
        case profilePath = "profile_path"
    }
    
}

extension Cast {
    
    var profileURL: URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: URLConfiguration.mediaPath + profilePath)
    }
    
}
