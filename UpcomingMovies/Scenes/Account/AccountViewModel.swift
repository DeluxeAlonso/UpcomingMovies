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
    
    private let authClient = AuthClient()
    private let userClient = AccountClient()
    private var requestToken: String?
    
    var showAuthPermission: (() -> Void)?
    var didSignIn: (() -> Void)?
    
    // MARK: - Initializers
    
    init(managedObjectContext: NSManagedObjectContext = PersistenceManager.shared.mainContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    // MARK: - Authentication
    
    func getRequestToken() {
        authClient.getRequestToken { result in
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
        userClient.getAccountDetail(managedObjectContext, with: sessionId) { result in
            switch result {
            case .success(let user):
                AuthenticationManager.shared.saveCurrentUser(sessionId,
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
    
    func buildProfileViewModel() -> ProfileViewModel? {
        let currentUser = AuthenticationManager.shared.currentUser()
        let options = ProfileOptions(collectionOptions: [.favorites, .watchlist],
                                     configurationOptions: [])
        return ProfileViewModel(managedObjectContext, userAccount: currentUser, options: options)
    }

    func buildCollectionListViewModel(_ option: ProfileCollectionOption) -> ProfileCollectionListViewModel? {
        return ProfileCollectionListViewModel(managedObjectContext: managedObjectContext,
                                              collectionOption: option)
    }
    
}
