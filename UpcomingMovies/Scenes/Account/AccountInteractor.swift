//
//  AccountInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/11/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class AccountInteractor: AccountInteractorProtocol {
    
    private let userUseCase: UserUseCaseProtocol
    private let accountUseCase: AccountUseCaseProtocol
    private let authUseCase: AuthUseCaseProtocol
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        userUseCase = useCaseProvider.userUseCase()
        accountUseCase = useCaseProvider.accountUseCase()
        authUseCase = useCaseProvider.authUseCase()
    }
    
    func getAuthPermissionURL(completion: @escaping (Result<URL, Error>) -> Void) {
        authUseCase.getAuthURL(completion: completion)
    }
    
    func signInUser(completion: @escaping (Result<User, Error>) -> Void) {
        authUseCase.signInUser { result in
            switch result {
            case .success(let user):
                self.userUseCase.saveUser(user)
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
