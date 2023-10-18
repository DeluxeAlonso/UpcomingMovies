//
//  MovieResult.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

struct MovieResult: Decodable, Paginable {

    let results: [Movie]
    let currentPage: Int
    let totalPages: Int

    private enum CodingKeys: String, CodingKey {
        case results
        case currentPage = "page"
        case totalPages = "total_pages"
    }

}
