//
//  Genre.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

public struct Genre: Decodable, Equatable {
    
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}

// MARK: - Test mockups

extension Genre {
    
    static func with(id: Int = 1,
                     name: String = "Genre 1") -> Genre {
        return Genre(id: id, name: name)
    }
    
}
