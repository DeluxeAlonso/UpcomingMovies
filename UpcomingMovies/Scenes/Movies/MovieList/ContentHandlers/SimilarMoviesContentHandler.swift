//
//  SimilarMoviesContentHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct SimilarMoviesContentHandler: MoviesContentHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    let movieId: Int
    
    var displayTitle: String {
        return "Similar Movies"
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getSimilarMovies(page: page, movieId: movieId, completion: completion)
    }
}
