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
    
    private var interactor: ProfileInteractorProtocol
    
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
    
    init(interactor: ProfileInteractorProtocol, userAccount: User?, options: ProfileOptions) {
        self.userAccount = userAccount
        self.collectionOptions = options.collectionOptions
        self.groupOptions = options.groupOptions
        
        self.interactor = interactor
        self.interactor.didUpdateUser = { [weak self] in
            self?.updateUserInfo()
            self?.reloadAccountInfo?()
        }
    }
    
    // MARK: - Private
    
    private func updateUserInfo() {
        guard let updatedUserAccount = interactor.getUser(with: userAccount?.id) else {
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
    
    func section(at index: Int) -> ProfileSection {
        return viewState.value.sections[index]
    }
    
    // MARK: - Networking
    
    func getAccountDetails() {
        interactor.getAccountDetail()
    }
    
}
