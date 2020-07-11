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
    
    private let interactor: AccountInteractorProtocol
    private let authHandler: AuthenticationHandler
    
    var showAuthPermission: Bindable<URL?> = Bindable(nil)
    var didSignIn: (() -> Void)?
    var didReceiveError: (() -> Void)?
    
    // MARK: - Initializers
    
    init(interactor: AccountInteractorProtocol,
         authHandler: AuthenticationHandler = AuthenticationHandler.shared) {
        self.interactor = interactor
        self.authHandler = authHandler
    }
    
    // MARK: - Authentication
    
    func isUserSignedIn() -> Bool {
        return authHandler.isUserSignedIn()
    }
    
    func signOutCurrentUser() {
        authHandler.deleteCurrentUser()
    }
    
    func startAuthorizationProcess() {
        interactor.getAuthPermissionURL { result in
            switch result {
            case .success(let url):
                self.showAuthPermission.value = url
            case .failure:
                self.didReceiveError?()
            }
        }
    }
    
    func signInUser() {
        interactor.signInUser { result in
            switch result {
            case .success:
                self.didSignIn?()
            case .failure:
                self.didReceiveError?()
            }
        }
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
