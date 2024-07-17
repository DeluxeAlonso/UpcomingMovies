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

    func getGenres(completion: @escaping (Result<[GenreProtocol], Error>) -> Void) {
        genreUseCase.fetchAll(completion: { result in
            switch result {
            case .success(let genres):
                completion(.success(genres.map(GenreModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        }, forceRefresh: false)
    }

    func getMovieVisits(completion: @escaping (Result<[MovieVisitProtocol], Error>) -> Void) {
        movieVisitUseCase.getMovieVisits(completion: { result in
            switch result {
            case .success(let visits):
                completion(.success(visits.map(MovieVisitModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}
