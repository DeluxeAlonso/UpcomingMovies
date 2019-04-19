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
    
    private var managedObjectContext: NSManagedObjectContext!
    
    let viewState: Bindable<ProfileViewState> = Bindable(.initial)
    
    private let userAccount: User?
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
    }
    
    // MARK: - Public
    
    func collectionOption(at index: Int) -> ProfileCollectionOption {
        return collectionOptions[index]
    }
    
}

// MARK: - View sections

extension ProfileViewModel {
    
    /// Collections refers to favorites list and watchlist
    enum ProfileSection {
        case accountInfo, collections, groups, signOut
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
