//
//  User.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public struct User: Decodable {
    
    public let id: Int
    public let name: String
    public let username: String
    public let includeAdult: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case includeAdult = "include_adult"
    }
    
    public init(id: Int, name: String, username: String, includeAdult: Bool) {
        self.id = id
        self.name = name
        self.username = username
        self.includeAdult = includeAdult
    }

}
