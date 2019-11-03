//
//  SplashViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class SplashViewModel {
    
    private let genreUseCase: GenreUseCaseProtocol
    private let genreClient = GenreClient()
    
    var genresFetched: (() -> Void)?
    
    init() {
        let useCaseProvider = InjectionFactory.useCaseProvider()
        self.genreUseCase = useCaseProvider.genreUseCase()
    }
    /**
     * Fetch all the movie genres and save them locally.
     */
    func getMovieGenres() {
        genreUseCase.fetchAll { result in
            switch result {
            case .success(let genres):
                self.genreUseCase.saveGenres(genres)
            case .failure:
                break
            }
            self.genresFetched?()
        }
    }

}
