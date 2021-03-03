//
//  MoviesByGenreInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct MoviesByGenreInteractor: MoviesInteractorProtocol {
    
    let movieUseCase: MovieUseCaseProtocol
    let genreId: Int
    let genreName: String
    
    init(useCaseProvider: UseCaseProviderProtocol, genreId: Int, genreName: String) {
        self.movieUseCase = useCaseProvider.movieUseCase()
        self.genreId = genreId
        self.genreName = genreName
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getMoviesByGenre(page: page, genreId: genreId, completion: completion)
    }
    
}
