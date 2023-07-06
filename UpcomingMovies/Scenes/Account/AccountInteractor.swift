//
//  AccountInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/11/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class AccountInteractor: AccountInteractorProtocol {

    private let authUseCase: AuthUseCaseProtocol
    private let authHandler: AuthenticationHandlerProtocol

    init(useCaseProvider: UseCaseProviderProtocol,
         authHandler: AuthenticationHandlerProtocol) {
        self.authUseCase = useCaseProvider.authUseCase()
        self.authHandler = authHandler
    }

    func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        authUseCase.signOutUser(completion: completion)
    }

    func currentUser() -> User? {
        authHandler.currentUser()
    }

}
