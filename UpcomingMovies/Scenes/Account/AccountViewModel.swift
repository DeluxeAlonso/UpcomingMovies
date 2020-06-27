//
//  AccountViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class AccountViewModel: AccountViewModelProtocol {
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let userUseCase: UserUseCaseProtocol
    private let accountUseCase: AccountUseCaseProtocol
    private let authUseCase: AuthUseCaseProtocol
    
    private var authHandler: AuthenticationHandler
    
    private(set) var authPermissionURL: URL?
    
    var showAuthPermission: (() -> Void)?
    var didSignIn: (() -> Void)?
    var didReceiveError: (() -> Void)?
    
    // MARK: - Initializers
    
    init(useCaseProvider: UseCaseProviderProtocol,
         authHandler: AuthenticationHandler = AuthenticationHandler.shared) {
        self.useCaseProvider = useCaseProvider
        self.userUseCase = self.useCaseProvider.userUseCase()
        self.accountUseCase = self.useCaseProvider.accountUseCase()
        self.authUseCase = self.useCaseProvider.authUseCase()
        
        self.authHandler = authHandler
    }
    
    // MARK: - Authentication
    
    func isUserSignedIn() -> Bool {
        return authHandler.isUserSignedIn()
    }
    
    func signOutCurrentUser() {
        authHandler.deleteCurrentUser()
    }
    
    func getRequestToken() {
        authUseCase.getAuthURL(completion: { result in
            switch result {
            case .success(let url):
                self.authPermissionURL = url
                self.showAuthPermission?()
            case .failure:
                self.didReceiveError?()
            }
        })
    }
    
    func getAccessToken() {
        authUseCase.signInUser(completion: { result in
            switch result {
            case .success(let user):
                self.userUseCase.saveUser(user)
                self.didSignIn?()
            case .failure:
                self.didReceiveError?()
            }
        })
    }
    
    // MARK: - View model building
    
    func currentUserAccount() -> User? {
        return authHandler.currentUser()
    }
    
    func profileOptions() -> ProfileOptions {
        return ProfileOptions(collectionOptions: [.favorites, .watchlist],
                              groupOptions: [.customLists],
                              configurationOptions: [])
    }

}
