//
//  MovieVisit.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

struct MovieVisit: Decodable {
    
    let id: Int
    let title: String
    let posterPath: String
    let createdAt: Date?
    
}
