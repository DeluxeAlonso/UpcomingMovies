//
//  ProfileInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/17/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class ProfileInteractor: ProfileInteractorProtocol {

    private let userUseCase: UserUseCaseProtocol
    private let accountUseCase: AccountUseCaseProtocol

    init(useCaseProvider: UseCaseProviderProtocol) {
        self.userUseCase = useCaseProvider.userUseCase()
        self.accountUseCase = useCaseProvider.accountUseCase()
    }

    // TODO: - Change this method to get the account detail given the id of a user account
    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void) {
        accountUseCase.getAccountDetail(completion: { result in
            switch result {
            case .success(let user):
                self.userUseCase.saveUser(user)
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}
