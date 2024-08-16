//
//  ProfileViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class ProfileViewModel: ProfileViewModelProtocol {

    // MARK: - Stored properties

    private var userAccount: UserProtocol
    private let interactor: ProfileInteractorProtocol
    private let factory: ProfileFactoryProtocol

    let reloadAccountInfo = PublishBindable<Void>().eraseToAnyBindable()
    let didUpdateAuthenticationState = BehaviorBindable<AuthenticationState?>(nil).eraseToAnyBindable()
    let didReceiveError = PublishBindable<Void>().eraseToAnyBindable()

    // MARK: - Computed properties

    var userInfoCell: ProfileAccountInfoCellViewModelProtocol? {
        ProfileAccountInfoCellViewModel(userAccount: userAccount)
    }

    var signOutTitle: String? {
        LocalizedStrings.signOut()
    }

    var signOutConfirmationTitle: String? {
        LocalizedStrings.signOutConfirmationTitle()
    }

    // MARK: - Initializers

    init(userAccount: UserProtocol,
         interactor: ProfileInteractorProtocol,
         factory: ProfileFactoryProtocol) {
        self.userAccount = userAccount
        self.interactor = interactor
        self.factory = factory
    }

    // MARK: - ProfileViewModelProtocol

    func section(at index: Int) -> ProfileSection {
        factory.sections[index]
    }

    func numberOfSections() -> Int {
        factory.sections.count
    }

    func numberOfRows(for section: Int) -> Int {
        let section = self.section(at: section)
        let profileOptions = factory.profileOptions(for: section)

        return profileOptions.count
    }

    func profileOption(for section: Int, at index: Int) -> ProfileOptionProtocol {
        let section = self.section(at: section)
        let profileOptions = factory.profileOptions(for: section)

        return profileOptions[index]
    }

    func buildProfileOptionCellViewModel(for section: Int,
                                         at index: Int) -> ProfileSelectableOptionCellViewModelProtocol {
        let profileOption = self.profileOption(for: section, at: index)
        return ProfileSelectableOptionCellViewModel(profileOption)
    }

    func buildSignOutCellViewModel() -> ProfileSignOutCellViewModelProtocol {
        ProfileSignOutCellViewModel()
    }

    // MARK: - Networking

    func getAccountDetails() {
        interactor.getAccountDetail { result in
            guard let user = result.wrappedValue else { return }

            // If there is no update to display we don't reload user account info
            if self.userAccount.hasUpdatedInfo(user) {
                self.userAccount = user
                self.reloadAccountInfo.send(())
            }
        }
    }

    func signOutCurrentUser() {
        interactor.signOutUser { result in
            switch result {
            case .success:
                self.didUpdateAuthenticationState.value = .justSignedOut
            case .failure:
                self.didReceiveError.send()
            }
        }
    }

}
