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
    
    private let authClient = AuthClient()
    private var managedObjectContext: NSManagedObjectContext
    private var requestToken: String?
    
    var showAuthPermission: (() -> Void)?
    
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
    
    func buildAuthPermissionViewModel() -> AuthPermissionViewModel? {
        guard let requestToken = requestToken else { return nil }
        return AuthPermissionViewModel(requestToken: requestToken)
    }
    
}
