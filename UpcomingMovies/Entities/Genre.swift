//
//  Genre.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

struct Genre: Decodable, Equatable {
    
    let id: Int
    let name: String
    
}

// MARK: - Test mockups

extension Genre {
    
    static func with(id: Int = 1,
                     name: String = "Genre 1") -> Genre {
        return Genre(id: id, name: name)
    }
    
}
