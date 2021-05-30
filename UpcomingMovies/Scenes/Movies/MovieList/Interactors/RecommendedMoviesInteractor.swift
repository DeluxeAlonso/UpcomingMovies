//
//  RecommendedMoviesInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 29/05/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

struct RecommendedMoviesInteractor: MoviesInteractorProtocol {

    private let accountUseCase: AccountUseCaseProtocol

    init(useCaseProvider: UseCaseProviderProtocol) {
        self.accountUseCase = useCaseProvider.accountUseCase()
    }

    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        accountUseCase.getRecommendedList(page: page, completion: completion)
    }

}
