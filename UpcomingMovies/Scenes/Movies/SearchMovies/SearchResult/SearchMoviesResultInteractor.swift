//
//  SearchMoviesResultInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class SearchMoviesResultInteractor: SearchMoviesResultInteractorProtocol {

    private let movieUseCase: MovieUseCaseProtocol
    private var movieSearchUseCase: MovieSearchUseCaseProtocol
    private let authHandler: AuthenticationHandlerProtocol

    var didUpdateMovieSearches: (() -> Void)?

    private var currentUser: UserProtocol? {
        authHandler.currentUser()
    }

    init(useCaseProvider: UseCaseProviderProtocol, authHandler: AuthenticationHandlerProtocol) {
        self.movieUseCase = useCaseProvider.movieUseCase()
        self.movieSearchUseCase = useCaseProvider.movieSearchUseCase()
        self.authHandler = authHandler

        self.movieSearchUseCase.didUpdateMovieSearch = { [weak self] in
            self?.didUpdateMovieSearches?()
        }
    }

    func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[MovieProtocol], Error>) -> Void) {
        let includeAdult = currentUser?.includeAdult ?? false
        movieUseCase.searchMovies(searchText: searchText,
                                  includeAdult: includeAdult,
                                  page: page, completion: { result in
            switch result {
            case .success(let movies):
                completion(.success(movies.map(MovieModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getMovieSearches(limit: Int? = nil,
                          completion: @escaping (Result<[MovieSearchProtocol], Error>) -> Void) {
        movieSearchUseCase.getMovieSearches(completion: { result in
            switch result {
            case .success(let movieSearches):
                if let limit = limit {
                    completion(.success(Array(movieSearches.prefix(limit)).map(MovieSearchModel.init)))
                } else {
                    completion(.success(movieSearches.map(MovieSearchModel.init)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func saveSearchText(_ searchText: String, completion: ((Result<Void, Error>) -> Void)?) {
        movieSearchUseCase.save(with: searchText, completion: completion ?? { _ in })
    }

}
