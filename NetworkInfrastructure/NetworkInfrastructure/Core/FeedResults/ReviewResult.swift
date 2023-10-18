//
//  ReviewResult.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/11/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

struct ReviewResult: Decodable, Paginable {

    let results: [Review]
    let currentPage: Int
    let totalPages: Int

    private enum CodingKeys: String, CodingKey {
        case results
        case currentPage = "page"
        case totalPages = "total_pages"
    }

}
