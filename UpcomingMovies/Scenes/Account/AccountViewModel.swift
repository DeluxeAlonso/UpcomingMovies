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
    private var requestToken: String?
    
    var showAuthPermission: (() -> Void)?
    var didSignIn: (() -> Void)?
    
    init(managedObjectContext: NSManagedObjectContext = PersistenceManager.shared.mainContext) {
        self.managedObjectContext = managedObjectContext
    }
    
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
                AuthenticationManager.shared.saveSessionId(sessionId)
                self.didSignIn?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func buildAuthPermissionViewModel() -> AuthPermissionViewModel? {
        guard let requestToken = requestToken else { return nil }
        return AuthPermissionViewModel(requestToken: requestToken)
    }
    
    func builProfileViewModel() -> ProfileViewModel? {
        return ProfileViewModel(managedObjectContext)
    }
    
    func buildFavoriteMoviesViewModel() -> FavoriteMoviesViewModel? {
        return FavoriteMoviesViewModel(managedObjectContext: managedObjectContext)
    }
    
}
