//
//  AccountViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import Domain

final class AccountViewModel {
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let userUseCase: UserUseCaseProtocol
    
    private var authManager: AuthenticationManager
    
    private let authClient = AuthClient()
    private let accountClient = AccountClient()
    private var requestToken: String?
    
    var showAuthPermission: (() -> Void)?
    var didSignIn: (() -> Void)?
    var didReceiveError: (() -> Void)?
    
    // MARK: - Initializers
    
    init(useCaseProvider: UseCaseProviderProtocol,
         authManager: AuthenticationManager = AuthenticationManager.shared) {
        self.useCaseProvider = useCaseProvider
        self.userUseCase = self.useCaseProvider.userUseCase()
        self.authManager = authManager
    }
    
    // MARK: - Authentication
    
    func isUserSignedIn() -> Bool {
        return authManager.isUserSignedIn()
    }
    
    func signOutCurrentUser() {
        authManager.deleteCurrentUser()
    }
    
    func getRequestToken() {
        let readAccessToken = authManager.readAccessToken
        authClient.getRequestToken(with: readAccessToken) { result in
            switch result {
            case .success(let requestToken):
                self.requestToken = requestToken.token
                self.showAuthPermission?()
            case .failure(let error):
                print(error.description)
                self.didReceiveError?()
            }
        }
    }
    
    func getAccessToken() {
        let readAccessToken = authManager.readAccessToken
        guard let requestToken = requestToken else { return }
        authClient.getAccessToken(with: readAccessToken, requestToken: requestToken) { result in
            switch result {
            case .success(let accessToken):
                self.authManager.saveAccessToken(accessToken)
                self.createSessionId(with: accessToken.token)
            case .failure(let error):
                print(error.description)
                self.didReceiveError?()
            }
        }
    }
    
    func createSessionId(with accessToken: String) {
        authClient.createSessionId(with: accessToken) { result in
            switch result {
            case .success(let sessionResult):
                guard let sessionId = sessionResult.sessionId else { return }
                self.getAccountDetails(sessionId)
            case .failure(let error):
                print(error.description)
                self.didReceiveError?()
            }
        }
    }
    
    private func getAccountDetails(_ sessionId: String) {
        accountClient.getAccountDetail(with: sessionId) { result in
            switch result {
            case .success(let user):
                print(user.name)
                self.userUseCase.saveUser(user)
                self.authManager.saveCurrentUser(sessionId,
                                            accountId: user.id)
                self.didSignIn?()
            case .failure(let error):
                print(error.description)
                self.didReceiveError?()
            }
        }
    }
    
    // MARK: - View model building
    
    func buildAuthPermissionViewModel() -> AuthPermissionViewModel? {
        guard let requestToken = requestToken else { return nil }
        return AuthPermissionViewModel(requestToken: requestToken)
    }
    
    func buildProfileViewModel() -> ProfileViewModel {
        let currentUser = authManager.currentUser()
        let options = ProfileOptions(collectionOptions: [.favorites, .watchlist],
                                     groupOptions: [.customLists],
                                     configurationOptions: [])
        return ProfileViewModel(useCaseProvider: useCaseProvider, userAccount: currentUser, options: options)
    }

    func buildCollectionListViewModel(_ option: ProfileCollectionOption) -> CollectionListViewModel {
        return CollectionListViewModel(useCaseProvider: useCaseProvider,
                                       collectionOption: option)
    }
    
    func buildCrearedListsViewModel(_ group: ProfileGroupOption) -> CustomListsViewModel {
        return CustomListsViewModel(useCaseProvider: useCaseProvider,
                                            groupOption: group)
    }
    
}
