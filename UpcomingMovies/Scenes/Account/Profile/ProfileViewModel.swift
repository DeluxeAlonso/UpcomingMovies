//
//  ProfileViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class ProfileViewModel: ProfileViewModelProtocol {
    
    private var userAccount: User?
    private let interactor: ProfileInteractorProtocol
    private let factory: ProfileFactoryProtocol
    
    var reloadAccountInfo: (() -> Void)?
    
    var userInfoCell: ProfileAccountInforCellViewModelProtocol? {
        guard let userAccount = userAccount else { return nil }
        return ProfileAccountInforCellViewModel(userAccount: userAccount)
    }
    
    var collectionOptionsCells: [ProfileSelectableOptionCellViewModelProtocol] {
        return factory.collectionOptions.map { ProfileSelectableOptionCellViewModel($0) }
    }
    
    var groupOptionsCells: [ProfileSelectableOptionCellViewModelProtocol] {
        return factory.groupOptions.map { ProfileSelectableOptionCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(userAccount: User?,
         interactor: ProfileInteractorProtocol,
         factory: ProfileFactoryProtocol) {
        self.userAccount = userAccount
        self.interactor = interactor
        self.factory = factory
    }
    
    // MARK: - Factory
    
    func collectionOption(at index: Int) -> ProfileCollectionOption {
        return factory.collectionOptions[index]
    }
    
    func groupOption(at index: Int) -> ProfileGroupOption {
        return factory.groupOptions[index]
    }
    
    func section(at index: Int) -> ProfileSection {
        return factory.sections[index]
    }
    
    func numberOfSections() -> Int {
        return factory.sections.count
    }
    
    // MARK: - Networking
    
    func getAccountDetails() {
        interactor.getAccountDetail { result in
            guard let user = try? result.get() else { return }
            
            // If there is no update to display we don't reload user account info
            if self.userAccount != user {
                self.userAccount = user
                self.reloadAccountInfo?()
            }
        }
    }
    
}
