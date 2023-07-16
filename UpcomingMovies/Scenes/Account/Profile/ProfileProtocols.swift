//
//  ProfileProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol ProfileViewModelProtocol {

    var userInfoCell: ProfileAccountInforCellViewModelProtocol? { get }

    var reloadAccountInfo: AnyPublishBindable<Void> { get }
    var didUpdateAuthenticationState: AnyBehaviorBindable<AuthenticationState?> { get }
    var didReceiveError: AnyPublishBindable<Void> { get }

    func section(at index: Int) -> ProfileSection
    func numberOfSections() -> Int
    func numberOfRows(for section: Int) -> Int

    func profileOption(for section: Int, at index: Int) -> ProfileOptionProtocol
    func buildProfileOptionCellViewModel(for section: Int,
                                         at index: Int) -> ProfileSelectableOptionCellViewModelProtocol

    func getAccountDetails()
    func signOutCurrentUser()

}

protocol ProfileInteractorProtocol {

    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void)
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
