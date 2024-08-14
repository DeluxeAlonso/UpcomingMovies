//
//  ProfileProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol ProfileViewModelProtocol {

    var userInfoCell: ProfileAccountInfoCellViewModelProtocol? { get }

    var reloadAccountInfo: AnyPublishBindable<Void> { get }
    var didUpdateAuthenticationState: AnyBehaviorBindable<AuthenticationState?> { get }
    var didReceiveError: AnyPublishBindable<Void> { get }

    var signOutTitle: String? { get }
    var signOutConfirmationTitle: String? { get }

    func section(at index: Int) -> ProfileSection
    func numberOfSections() -> Int
    func numberOfRows(for section: Int) -> Int

    func profileOption(for section: Int, at index: Int) -> ProfileOptionProtocol
    func buildProfileOptionCellViewModel(for section: Int,
                                         at index: Int) -> ProfileSelectableOptionCellViewModelProtocol
    func buildSignOutCellViewModel() -> ProfileSignOutCellViewModelProtocol

    func getAccountDetails()
    func signOutCurrentUser()

}

protocol ProfileInteractorProtocol {

    func getAccountDetail(completion: @escaping (Result<UserProtocol, Error>) -> Void)
    func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void)

}

protocol ProfileFactoryProtocol {

    var sections: [ProfileSection] { get }

    func profileOptions(for section: ProfileSection) -> [ProfileOptionProtocol]

}

protocol ProfileViewControllerDelegate: UIViewController, AuthenticationStateDelegate {

    func profileViewController(didTapProfileOption option: ProfileOptionProtocol)

}

protocol ProfileCoordinatorProtocol: AnyObject {}
