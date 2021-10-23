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

    // MARK: - Stored properties

    private var userAccount: User?
    private let interactor: ProfileInteractorProtocol
    private let factory: ProfileFactoryProtocol

    var reloadAccountInfo: (() -> Void)?

    // MARK: - Computed properties

    var userInfoCell: ProfileAccountInforCellViewModelProtocol? {
        guard let userAccount = userAccount else { return nil }
        return ProfileAccountInforCellViewModel(userAccount: userAccount)
    }

    // MARK: - Initializers

    init(userAccount: User?,
         interactor: ProfileInteractorProtocol,
         factory: ProfileFactoryProtocol) {
        self.userAccount = userAccount
        self.interactor = interactor
        self.factory = factory
    }

    // MARK: - ProfileViewModelProtocol

    func section(at index: Int) -> ProfileSection {
        return factory.sections[index]
    }

    func numberOfSections() -> Int {
        return factory.sections.count
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
