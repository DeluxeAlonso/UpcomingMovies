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

    init(useCaseProvider: UseCaseProviderProtocol) {
        self.accountUseCase = useCaseProvider.accountUseCase()
    }

    func getCustomListMovies(listId: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        accountUseCase.getCustomListMovies(listId: listId, completion: completion)
    }

}
