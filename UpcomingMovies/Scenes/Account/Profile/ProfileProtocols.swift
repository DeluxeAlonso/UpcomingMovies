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

    var reloadAccountInfo: (() -> Void)? { get set }

    func section(at index: Int) -> ProfileSection
    func numberOfSections() -> Int
    func numberOfRows(for section: Int) -> Int

    func profileOption(for section: Int, at index: Int) -> ProfileOptionProtocol
    func buildProfileOptionCellViewModel(for section: Int,
                                         at index: Int) -> ProfileSelectableOptionCellViewModelProtocol

    func getAccountDetails()

}

protocol ProfileInteractorProtocol {

    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void)

}

protocol ProfileFactoryProtocol {

    var sections: [ProfileSection] { get }

    func profileOptions(for section: ProfileSection) -> [ProfileOptionProtocol]

}

protocol ProfileViewControllerDelegate: UIViewController {

    func profileViewController(didTapProfileOption option: ProfileOptionProtocol)
    func profileViewController(didSignOut signedOut: Bool)

}
