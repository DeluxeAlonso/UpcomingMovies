//
//  SearchOptionsInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class SearchOptionsInteractor: SearchOptionsInteractorProtocol {
    
    private var movieVisitUseCase: MovieVisitUseCaseProtocol
    private let genreUseCase: GenreUseCaseProtocol
    
    var didUpdateMovieVisit: (() -> Void)?
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.movieVisitUseCase = useCaseProvider.movieVisitUseCase()
        self.genreUseCase = useCaseProvider.genreUseCase()
        
        self.movieVisitUseCase.didUpdateMovieVisit = { [weak self] in
            self?.didUpdateMovieVisit?()
        }
    }
    
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        genreUseCase.fetchAll(completion: completion)
    }
    
    func getMovieVisits() -> [MovieVisit] {
        return movieVisitUseCase.getMovieVisits()
    }
    
    func hasMovieVisits() -> Bool {
        return movieVisitUseCase.hasMovieVisits()
    }
    
}
