//
//  SearchOptionsInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class SearchOptionsInteractor: SearchOptionsInteractorProtocol {

    private var movieVisitUseCase: MovieVisitUseCaseProtocol
    private let genreUseCase: GenreUseCaseProtocol

    var didUpdateMovieVisit: (() -> Void)?

    init(movieVisitUseCase: MovieVisitUseCaseProtocol,
         genreUseCase: GenreUseCaseProtocol) {
        self.movieVisitUseCase = movieVisitUseCase
        self.genreUseCase = genreUseCase

        self.movieVisitUseCase.didUpdateMovieVisit = { [weak self] in
            self?.didUpdateMovieVisit?()
        }
    }

    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        genreUseCase.fetchAll(completion: completion, forceRefresh: false)
    }

    func getMovieVisits(completion: @escaping (Result<[MovieVisit], Error>) -> Void) {
        movieVisitUseCase.getMovieVisits(completion: completion)
    }

}
