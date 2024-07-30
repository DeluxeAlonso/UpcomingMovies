//
//  ProfileInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/17/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class ProfileInteractor: ProfileInteractorProtocol {

    private let userUseCase: UserUseCaseProtocol
    private let authUseCase: AuthUseCaseProtocol
    private let accountUseCase: AccountUseCaseProtocol

    init(userUseCase: UserUseCaseProtocol,
         authUseCase: AuthUseCaseProtocol,
         accountUseCase: AccountUseCaseProtocol) {
        self.userUseCase = userUseCase
        self.authUseCase = authUseCase
        self.accountUseCase = accountUseCase
    }

    // TODO: - Change this method to get the account detail given the id of a user account
    func getAccountDetail(completion: @escaping (Result<UserProtocol, Error>) -> Void) {
        accountUseCase.getAccountDetail(completion: { result in
            switch result {
            case .success(let user):
                self.userUseCase.saveUser(user)
                completion(.success(UserModel(user)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        authUseCase.signOutUser(completion: completion)
    }

}
