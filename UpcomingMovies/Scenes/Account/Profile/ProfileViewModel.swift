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
    
    let settingsOptions: [ProfileSettingsOption] = [.favorites]
    var settingsOptionsCells: [ProfileSettingCellViewModel] {
        return settingsOptions.map { ProfileSettingCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(_ managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
}

// MARK: - View sections

extension ProfileViewModel {
    
    enum ProfileSection {
        case userInfo, settings, signOut
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
                return [.settings, .signOut]
            }
        }
        
    }
    
}

enum ProfileSettingsOption {
    case favorites
    
    var title: String? {
        switch self {
        case .favorites:
            return "Favorites"
        }
    }
    
}
