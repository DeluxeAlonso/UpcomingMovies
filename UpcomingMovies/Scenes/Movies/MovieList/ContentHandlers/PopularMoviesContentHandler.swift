//
//  PopularMoviesContentHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct PopularMoviesContentHandler: MoviesInteractorProtocol {
    
    let movieUseCase: MovieUseCaseProtocol
    
    var displayTitle: String {
        return "Popular Movies"
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getPopularMovies(page: page, completion: completion)
    }
    
}
