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
    
    private let useCaseProvider: UseCaseProviderProtocol
    private var userUseCase: UserUseCaseProtocol
    private let accountUseCase: AccountUseCaseProtocol
    
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
    
    init(useCaseProvider: UseCaseProviderProtocol, userAccount: User?, options: ProfileOptions) {
        self.userAccount = userAccount
        self.collectionOptions = options.collectionOptions
        self.groupOptions = options.groupOptions
        
        self.useCaseProvider = useCaseProvider
        self.accountUseCase = self.useCaseProvider.accountUseCase()
        self.userUseCase = self.useCaseProvider.userUseCase()
        self.userUseCase.didUpdateUser = { [weak self] in
            self?.updateUserAccount()
            self?.reloadAccountInfo?()
        }
    }
    
    // MARK: - Private
    
    private func updateUserAccount() {
        guard let userAccountId = userAccount?.id,
            let updatedUserAccount = userUseCase.find(with: userAccountId) else {
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
    
    // TODO: - Change this method to get the account detail given the id of a user account
    func getAccountDetails() {
        accountUseCase.getAccountDetail(completion: { result in
            switch result {
            case .success(let user):
                self.userUseCase.saveUser(user)
            case .failure:
                break
            }
        })
    }
    
}
