//
//  ProfileProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol ProfileViewModelProtocol {
    
    var userInfoCell: ProfileAccountInforCellViewModelProtocol? { get }
    var collectionOptionsCells: [ProfileSelectableOptionCellViewModelProtocol] { get }
    var recommendedOptionsCells: [ProfileSelectableOptionCellViewModelProtocol] { get }
    var groupOptionsCells: [ProfileSelectableOptionCellViewModelProtocol] { get }
    
    var reloadAccountInfo: (() -> Void)? { get set }

    func profileOption(for section: Int, at index: Int) -> ProfileOptionProtocol
    
    func section(at index: Int) -> ProfileSection
    func numberOfSections() -> Int
    
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
