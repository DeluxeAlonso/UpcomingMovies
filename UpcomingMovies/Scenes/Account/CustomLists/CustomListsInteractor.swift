//
//  CustomListsInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/26/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class CustomListsInteractor: CustomListsInteractorProtocol {

    private let accountUseCase: AccountUseCaseProtocol

    init(accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase
    }

    func getCustomLists(page: Int?, completion: @escaping (Result<[ListProtocol], Error>) -> Void) {
        accountUseCase.getCustomLists(page: page, completion: { result in
            switch result {
            case .success(let lists):
                completion(.success(lists.map { ListModel($0) }))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}
