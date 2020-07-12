//
//  AuthenticationManager.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol AuthenticationHandlerProtocol {
    
    func currentUser() -> User?
    func isUserSignedIn() -> Bool
    func deleteCurrentUser()
    
}

class AuthenticationHandler: AuthenticationHandlerProtocol {
    
    static let shared = AuthenticationHandler()
    
    private let authUseCase: AuthUseCaseProtocol
    private let userUseCase: UserUseCaseProtocol

    // MARK: - Initializers
    
    init() {
        let useCaseProvider = InjectionFactory.useCaseProvider()
        self.authUseCase = useCaseProvider.authUseCase()
        self.userUseCase = useCaseProvider.userUseCase()
    }
    
    // MARK: - Authentitacion Persistence
    
    func currentUser() -> User? {
        guard let userId = authUseCase.currentUserId() else { return nil }
        return userUseCase.find(with: userId)
    }
    
    func isUserSignedIn() -> Bool {
        return currentUser() != nil
    }
    
    func deleteCurrentUser() {
        authUseCase.signOutUser(completion: { _ in })
    }
    
}
