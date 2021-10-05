//
//  GenreHandlerProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 15/03/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

/**
 * Provides methods to access the movie genres names
 * because they are not always sent to us through the endpoints.
 */
protocol GenreHandlerProtocol {

    func setGenres(_ genres: [Genre])
    func getGenreName(for genreId: Int) -> String?

}
