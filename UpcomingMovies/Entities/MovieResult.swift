//
//  MovieResult.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

struct MovieResult: Decodable {

    let results: [Movie]?
    let currentPage: Int
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case results
        case currentPage = "page"
        case totalPages = "total_pages"
    }
    
    var hasMorePages: Bool {
        return currentPage < totalPages
    }
    
    var nextPage: Int {
        return hasMorePages ? currentPage + 1 : currentPage
    }
    
}
