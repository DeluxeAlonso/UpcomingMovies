//
//  UpcomingMoviesContentHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct UpcomingMoviesContentHandler: MoviesContentHandlerProtocol {
    
    let movieUseCase: MovieUseCaseProtocol
    
    var displayTitle: String {
        return "Upcoming Movies"
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getUpcomingMovies(page: page, completion: completion)
    }
    
}
