//
//  SearchMoviesResultInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class SearchMoviesResultInteractor: SearchMoviesResultInteractorProtocol {
    
    private let movieUseCase: MovieUseCaseProtocol
    private let movieSearchUseCase: MovieSearchUseCaseProtocol
    private let authHandler: AuthenticationHandlerProtocol
    
    var didUpdateMovieSearch: (() -> Void)?
    
    init(useCaseProvider: UseCaseProviderProtocol, authHandler: AuthenticationHandlerProtocol) {
        self.movieUseCase = useCaseProvider.movieUseCase()
        self.movieSearchUseCase = useCaseProvider.movieSearchUseCase()
        self.authHandler = authHandler
        
        self.didUpdateMovieSearch = movieSearchUseCase.didUpdateMovieSearch
    }
    
    func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let includeAdult = authHandler.currentUser()?.includeAdult ?? false
        movieUseCase.searchMovies(searchText: searchText,
                                  includeAdult: includeAdult,
                                  page: page, completion: completion)
    }
    
    func saveSearchText(_ searchText: String) {
        movieSearchUseCase.save(with: searchText)
    }
    
    func getMovieSearches() -> [MovieSearch] {
        return movieSearchUseCase.getMovieSearches()
    }
    
}
