//
//  MoviesByGenreContentHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct MoviesByGenreContentHandler: MoviesInteractorProtocol {
    let movieUseCase: MovieUseCaseProtocol
    let genreId: Int
    let genreName: String
    
    var displayTitle: String {
        return genreName
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getMoviesByGenre(page: page, genreId: genreId, completion: completion)
    }
}
