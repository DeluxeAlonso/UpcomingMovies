//
//  User.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    let id: Int
    let name: String
    let username: String
    let includeAdult: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case includeAdult = "include_adult"
    }

}
