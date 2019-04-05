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
    
    private let options: [ProfileOption]
    var collectionOptionsCells: [ProfileCollectionCellViewModel] {
        let collectionOptions = options.filter { $0.type == .collection }
        return collectionOptions.map { ProfileCollectionCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(_ managedObjectContext: NSManagedObjectContext, userAccount: User?, options: [ProfileOption]) {
        self.managedObjectContext = managedObjectContext
        self.userAccount = userAccount
        self.options = options
    }
    
    // MARK: - Public
    
    func collectionOption(at index: Int) -> ProfileOption {
        let collectionOptions = options.filter { $0.type == .collection }
        guard index < collectionOptions.count else { fatalError() }
        return collectionOptions[index]
    }
    
}

// MARK: - View sections

extension ProfileViewModel {
    
    enum ProfileSection {
        case accountInfo, collections, signOut
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
                return [.accountInfo, .collections, .signOut]
            }
        }
        
    }
    
}
