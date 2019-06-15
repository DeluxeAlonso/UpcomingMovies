//
//  ProfileViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class ProfileViewModel {
    
    private var managedObjectContext: NSManagedObjectContext
    private var userStore: PersistenceStore<User>!
    
    private let accountClient = AccountClient()
    
    let viewState: Bindable<ProfileViewState> = Bindable(.initial)
    
    var reloadAccountInfo: (() -> Void)?
    
    private var userAccount: User?
    var userInfoCell: ProfileAccountInforCellViewModel? {
        guard let userAccount = userAccount else { return nil }
        return ProfileAccountInforCellViewModel(userAccount: userAccount)
    }
    
    private let collectionOptions: [ProfileCollectionOption]
    var collectionOptionsCells: [ProfileSelectableOptionCellViewModel] {
        return collectionOptions.map { ProfileSelectableOptionCellViewModel($0) }
    }
    
    private let groupOptions: [ProfileGroupOption]
    var groupOptionsCells: [ProfileSelectableOptionCellViewModel] {
        return groupOptions.map { ProfileSelectableOptionCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(_ managedObjectContext: NSManagedObjectContext, userAccount: User?, options: ProfileOptions) {
        self.managedObjectContext = managedObjectContext
        self.userAccount = userAccount
        self.collectionOptions = options.collectionOptions
        self.groupOptions = options.groupOptions
        setupStores()
    }
    
    // MARK: - Private
    
    private func setupStores() {
        userStore = PersistenceStore(managedObjectContext)
        userStore.configureResultsContoller(notifyChangesOn: [.insert])
        userStore.delegate = self
    }
    
    private func updateUserAccount() {
        guard let userAccountId = userAccount?.id,
            let updatedUserAccount = userStore.find(with: userAccountId) else {
                return
        }
        userAccount = updatedUserAccount
    }
    
    // MARK: - Public
    
    func collectionOption(at index: Int) -> ProfileCollectionOption {
        return collectionOptions[index]
    }
    
    func groupOption(at index: Int) -> ProfileGroupOption {
        return groupOptions[index]
    }
    
    // MARK: - Networking
    
    // TODO: - Change this method to get the account detail given the id of a user account
    func getAccountDetails() {
        guard let credentials = AuthenticationManager.shared.userCredentials() else {
            return
        }
        accountClient.getAccountDetail(managedObjectContext, with: credentials.sessionId) { _ in }
    }
    
}

// MARK: - View sections

extension ProfileViewModel {
    
    enum ProfileSection {
        /// Section to show the profile user info
        case accountInfo
        
        /// Shows the user's collections like favorites
        case collections
        
        /// Shows the user's created lists
        case groups
        
        /// Shows the sign out Button
        case signOut
    }
    
    func section(at index: Int) -> ProfileSection {
        return viewState.value.sections[index]
    }
    
}

// MARK: - View states

extension ProfileViewModel {
    
    enum ProfileViewState {
        case initial
        
        var sections: [ProfileSection] {
            switch self {
            case .initial:
                return [.accountInfo, .collections, .groups, .signOut]
            }
        }
    }
    
}

// MARK: - PersistenceStoreDelegate

extension ProfileViewModel: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {}
    
    func persistenceStore(didUpdateEntity update: Bool) {
        updateUserAccount()
        reloadAccountInfo?()
    }
    
}
