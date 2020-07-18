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
    
    private var userUseCase: UserUseCaseProtocol
    private let accountUseCase: AccountUseCaseProtocol
    
    var didUpdateUser: (() -> Void)?
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.userUseCase = useCaseProvider.userUseCase()
        self.accountUseCase = useCaseProvider.accountUseCase()
        
        self.didUpdateUser = self.userUseCase.didUpdateUser
    }
    
    func getUser(with id: Int?) -> User? {
        guard let id = id, let user = userUseCase.find(with: id) else {
            return nil
        }
        return user
    }
    
    // TODO: - Change this method to get the account detail given the id of a user account
    func getAccountDetail() {
        accountUseCase.getAccountDetail(completion: { result in
            switch result {
            case .success(let user):
                self.userUseCase.saveUser(user)
            case .failure:
                break
            }
        })
    }
    
}
