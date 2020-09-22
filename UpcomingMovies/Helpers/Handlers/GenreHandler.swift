//
//  GenreHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/22/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol GenreHandlerProtocol {
    
    func setGenres(_ genres: [Genre])
    func getGenreName(for genreId: Int) -> String?
    
}

/**
 * Provides methods to access the movie genres names
 * because they are not always sent to us through the endpoints.
 */
class GenreHandler: GenreHandlerProtocol {
    
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
