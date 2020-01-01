//
//  Cast.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public struct Cast {
    
    public let id: Int
    public let character: String
    public let name: String
    public let profileURL: URL?
    
    public init(id: Int, character: String, name: String, profileURL: URL?) {
        self.id = id
        self.character = character
        self.name = name
        self.profileURL = profileURL
    }
    
}
