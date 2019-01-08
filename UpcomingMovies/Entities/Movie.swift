//
//  Movie.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    let title: String?
    let genres: [Int]?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let overview: String?
    
    var genreName: String {
        guard let genres = genres,
            !genres.isEmpty,
            let genre = genres.first else {
            return "-"
        }
        return AppManager.shared.findGenre(withId: genre)
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case overview
        case genres = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }

}
