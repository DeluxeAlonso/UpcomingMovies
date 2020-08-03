//
//  MovieVideosInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/2/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct MovieVideosInteractor: MovieVideosInteractorProtocol {
    
    private let movieUseCase: MovieUseCaseProtocol
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.movieUseCase = useCaseProvider.movieUseCase()
    }
    
    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[Video], Error>) -> Void) {
        movieUseCase.getMovieVideos(for: movieId, page: page, completion: completion)
    }
    
}
