//
//  CustomListDetailInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class CustomListDetailInteractor: CustomListDetailInteractorProtocol {

    private let accountUseCase: AccountUseCaseProtocol

    init(accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase
    }

    func getCustomListMovies(listId: String, completion: @escaping (Result<[MovieProtocol], Error>) -> Void) {
        accountUseCase.getCustomListMovies(listId: listId) { result in
            switch result {
            case .success(let movies):
                completion(.success(movies.map(MovieModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
