//
//  Review.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

struct Review: Decodable {
    
    let id: String
    let authorName: String
    let content: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case authorName = "author"
        case content
    }
    
}
