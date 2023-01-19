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
    private let movieSearchUseCase: MovieSearchUseCaseProtocol
    private let authHandler: AuthenticationHandlerProtocol

    init(useCaseProvider: UseCaseProviderProtocol, authHandler: AuthenticationHandlerProtocol) {
        self.movieUseCase = useCaseProvider.movieUseCase()
        self.movieSearchUseCase = useCaseProvider.movieSearchUseCase()
        self.authHandler = authHandler
    }

    func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let includeAdult = authHandler.currentUser()?.includeAdult ?? false
        movieUseCase.searchMovies(searchText: searchText,
                                  includeAdult: includeAdult,
                                  page: page, completion: completion)
    }

    func getMovieSearches(completion: @escaping (Result<[MovieSearch], Error>) -> Void) {
        movieSearchUseCase.getMovieSearches(completion: completion)
    }

    func saveSearchText(_ searchText: String, completion: @escaping (Result<Void, Error>) -> Void) {
        movieSearchUseCase.save(with: searchText, completion: completion)
    }

}
