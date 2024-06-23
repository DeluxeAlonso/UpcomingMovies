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

    init(accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase
    }

    func getMovies(page: Int, completion: @escaping (Result<[MovieProtocol], Error>) -> Void) {
        accountUseCase.getRecommendedList(page: page, completion: { result in
            switch result {
            case .success(let movies):
                completion(.success(movies.map(MovieModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}
