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
    var groupOptionsCells: [ProfileSelectableOptionCellViewModelProtocol] { get }
    
    var reloadAccountInfo: (() -> Void)? { get set }
    
    func collectionOption(at index: Int) -> ProfileCollectionOption
    func groupOption(at index: Int) -> ProfileGroupOption
    
    func section(at index: Int) -> ProfileSection
    func numberOfSections() -> Int
    
    func getAccountDetails()
    
}

protocol ProfileInteractorProtocol {
    
    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void)
    
}

protocol ProfileFactoryProtocol {
    
    var sections: [ProfileSection] { get }
    var collectionOptions: [ProfileCollectionOption] { get }
    var groupOptions: [ProfileGroupOption] { get }
    var configurationOptions: [ProfileConfigurationOption] { get }
    
}

protocol ProfileViewControllerDelegate: AnyObject {

    func profileViewController(didTapCollection collection: ProfileCollectionOption)
    func profileViewController(didTapGroup group: ProfileGroupOption)
    func profileViewController(didTapSignOutButton tapped: Bool)
    
}
