//
//  List.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

struct List: Decodable, Equatable {
    
    let id: Int
    let name: String
    let description: String?
    let posterPath: String?
    let movieCount: Int
    let movies: [Movie]?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description
        case posterPath = "poster_path"
        case movieCount = "item_count"
        case movies = "items"
    }
    
}
