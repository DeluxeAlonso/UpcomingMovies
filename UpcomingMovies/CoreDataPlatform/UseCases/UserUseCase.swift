//
//  UserUseCase.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class UserUseCase: UserUseCaseProtocol {
    
    private let store: PersistenceStore<CDUser>
    
    var didUpdateUser: (() -> Void)?
    
    init(store: PersistenceStore<CDUser>) {
        self.store = store
        self.store.configureResultsContoller(sortDescriptors: CDUser.defaultSortDescriptors,
                                             notifyChangesOn: [.insert])
        self.store.delegate = self
    }
    
    func find(with id: Int) -> User? {
        return store.find(with: id)?.asDomain()
    }
    
    func saveUser(_ user: User) {
        self.store.saveUser(user)
    }
    
}

// MARK: - PersistenceStoreDelegate

extension UserUseCase: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {}
    
    func persistenceStore(didUpdateEntity update: Bool) {
        didUpdateUser?()
    }
    
}

