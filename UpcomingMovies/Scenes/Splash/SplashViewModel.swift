//
//  SplashViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

final class SplashViewModel {
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let genreUseCase: GenreUseCaseProtocol
    
    private let genreClient = GenreClient()
    
    var genresFetched: (() -> Void)?
    
    init(useCaseProvider: UseCaseProviderProtocol = UseCaseProvider()) {
        self.useCaseProvider = useCaseProvider
        self.genreUseCase = self.useCaseProvider.genreUseCase()
    }
    /**
     * Fetch all the movie genres and save them in the AppManager Singleton.
     */
    func getMovieGenres() {
        genreClient.getAllGenres { result in
            switch result {
            case .success(let genreResult):
                self.genreUseCase.saveGenres(genreResult.genres)
            case .failure:
                break
            }
            self.genresFetched?()
        }
    }

}
