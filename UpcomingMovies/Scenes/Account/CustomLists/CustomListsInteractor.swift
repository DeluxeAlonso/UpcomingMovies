//
//  CustomListsInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/26/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class CustomListsInteractor: CustomListsInteractorProtocol {

    private let accountUseCase: AccountUseCaseProtocol

    init(useCaseProvider: UseCaseProviderProtocol) {
        self.accountUseCase = useCaseProvider.accountUseCase()
    }

    func getCustomLists(page: Int?, completion: @escaping (Result<[List], Error>) -> Void) {
        accountUseCase.getCustomLists(page: page, completion: completion)
    }

}
