//
//  AccountViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class AccountViewModel {
    
    private var managedObjectContext: NSManagedObjectContext
    private var authManager: AuthenticationManager
    
    private let authClient = AuthClient()
    private let accountClient = AccountClient()
    private var requestToken: String?
    
    var showAuthPermission: (() -> Void)?
    var didSignIn: (() -> Void)?
    
    // MARK: - Initializers
    
    init(managedObjectContext: NSManagedObjectContext = PersistenceManager.shared.mainContext,
         authManager: AuthenticationManager = AuthenticationManager.shared) {
        self.managedObjectContext = managedObjectContext
        self.authManager = authManager
    }
    
    // MARK: - Authentication
    
    func getRequestToken() {
        let readAccessToken = authManager.readAccessToken
        authClient.getRequestToken(with: readAccessToken) { result in
            switch result {
            case .success(let requestToken):
                self.requestToken = requestToken.token
                self.showAuthPermission?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func createSessionId() {
        guard let requestToken = requestToken else { return }
        authClient.createSessionId(with: requestToken) { result in
            switch result {
            case .success(let sessionResult):
                guard let sessionId = sessionResult.sessionId else { return }
                self.getAccountDetails(sessionId)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAccountDetails(_ sessionId: String) {
        accountClient.getAccountDetail(managedObjectContext, with: sessionId) { result in
            switch result {
            case .success(let user):
                self.authManager.saveCurrentUser(sessionId,
                                            accountId: user.id)
                self.didSignIn?()
            case .failure(let error):
                print(error.description)
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
        return ProfileViewModel(managedObjectContext, userAccount: currentUser, options: options)
    }

    func buildCollectionListViewModel(_ option: ProfileCollectionOption) -> CollectionListViewModel {
        return CollectionListViewModel(managedObjectContext: managedObjectContext,
                                              collectionOption: option)
    }
    
    func buildCrearedListsViewModel(_ group: ProfileGroupOption) -> CustomListsViewModel {
        return CustomListsViewModel(managedObjectContext,
                                            groupOption: group)
    }
    
}
