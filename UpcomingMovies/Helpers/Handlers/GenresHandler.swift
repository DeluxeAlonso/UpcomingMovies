//
//  GenreHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/22/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

/**
 * Provides methods to access the movie genres names
 * because they are no always sent to us through the endpoints.
 */
class GenreHandler {
    
    static let shared: GenreHandler = GenreHandler()
    
    private var genres: [Genre] = []
    
    init() {}
    
    func setGenres(_ genres: [Genre]) {
        self.genres = genres
    }
    
    func getGenreName(for genreId: Int) -> String? {
        guard let genre = genres.filter({ $0.id == genreId }).first else { return nil }
        return genre.name
    }
    
}
